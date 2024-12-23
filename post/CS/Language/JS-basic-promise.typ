#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import "/book.typ": book-page
#show: book-page.with(title: "Basic of TypeScript")

#align(center, text(17pt)[
  = Promise of JavaScript
])

= 1 Introduction: callbacks

Many functions are provided by the host environments that allow we to schedule *asynchronous* actions, In other words, actions that we initiate now, but they finish later.

Below is an asynchronous action, loading scripts and modules:

```javascript
// ------ src/script.js -------
function test() {
  alert("Test function is called.");
}

test();
// ----------------------------

function loadScript(src) {
  let script = document.createElement('script');
  script.src = src;
  document.head.append(script);
}

loadScript('src/script.js');

test(); // nothing happens

// the code below loadScript doesn't wait for the script loading to finish
// if there is a function declared in 'src/script.js', that will not be executed
```

The `loadScript` function doesn't provide a way to track the load completion. If we'd like to know when the loaded script happens to use new functions and variables from the loaded script, we need to add a `callback` function as a second argument to `loadScript` that should execute when the script loads:

```javascript
function loadScript(src, callback) {
  let script = document.createElement("script");
  script.src = src;

  script.onload = () => callback(script);

  document.head.append(script);
}

loadScript('src/script.js', (script) => {
  alert(`The script ${script.src} is loaded`);
  // The script http://127.0.0.1:3000/JavaScript/demo/script2.js is loaded
  test();
  // Test function is called
});
```

That's called a "callback-based" style of asynchronous programming. A function that does something asynchronous should provide a `callback` argument where we put the function to run after it's complete.

But that is the *problem*: if we want a callback in callback, or callback in callback in callback in ...? Just like this:

```javascript
loadScript('script1.js', (script) => {
  alert("script1 has been loaded");
  loadScript("script2.js", (script) => {
    alert("script2 has been loaded")
  });
});
```

And we even don't handle the loading error! If we take the loading error into consider, it may look like this:

```javascript
loadScript("script1.js", (error, script) => {
  if (error) {
    // handle the error
  } else {
    loadScript("script2.js", (error, script) => {
      if (error) {
        // handle the error
      } else {
        // ...
      }
    });
  }
});
```

As you can see, such a horrible scene! This style of asynchronous code is called *pyramid of doom*, although there is a way to refactor this style, but such way is still not elegant.

= 2 Promise

The constructor syntax for a *promise* object is

```javascript
let promise = new Promise(function(resolve, reject) {
  // the producing code
});
```

The function passed to `new Promise` is called the *executor*, when `new Promise` is created, the executor runs automatically. It contains the producing code which should eventually produce the result. Its arguments `resolve` and `reject` are callbacks provided by JavaScript. When the executor obtains the result, it should call one of these callbacks:
- `resolve(value)`, if the job is finished successfully, with result `value`;
- `reject(error)`, if an error has occurred, there `error` is the error object.

The `promise` object returned by the `new Promise` constructor has these internal properties:
- `state`, initially `"pending"`, then changes to either `"fulfilled"` when `resolve` is called or `"rejected"` when `reject` is called.
- `result`, initially `undefined`, then changes to `value` when `resolve(value)` is called or `error` when `reject(error)` is called.

Notice that these properties are internal, we can't directly access them, but we can use methods `.then()`, `.catch()` and `.finally()` for that. And there are their usage:

+ The syntax of `.then()` method is

  ```javascript
  promise.then(
    function(result) { /* handle a successful result */ }
    function(error) { /* handle an error */ }
  );
  ```

  the first argument of `.then()` is the `resolve` function and the second argument of `.then()` is the `reject` function, we can write them as arrow function:

  ```javascript
  let promise = new Promise((resolve, reject) => {
    setTimeout(() => reject(new Error("There is an error.")), 1000);
  });

  promise.then(
    result => alert(result),
    error => alert(error)
  );
  ```

  If we are interested only in successful completions, then we can provide only one argument to `.then()`:

  ```javascript
  let promise = new Promise((resolve) => {
    setTimeout(() => resolve("Done!"))), 1000);
  });

  promise.then(result => alert(result));
  ```

+ If we are interested only in errors, then we can use `null` as the first argument: `.then(null, errorHandlingFunction)`. Or we can simply use `.catch(errorHandlingFunction)`:

  ```javascript
  let promise = new Promise((resolve, reject) => {
    setTimeout(() => reject(new Error("There is an error.")), 1000);
  });

  promise.catch(alert);
  promise.then(null, alert);
  ```

+ The call `.finally(f)` is similar to `.then(f,f)` in the sense that `f` runs always, when the promise is settled: be it resolve or reject. The idea of `finally` is to set up a handler for performing cleanup / finalizing after the previous operation are complete. The code may look like this:

  ```javascript
  new Promise((resolve, reject) => {
    /* do something that takes time, and then call resolve or reject function */
  })
    .finally(() => stop loading indicator)
    .then(result => show result,
          error => show error)
  ```

  The `finally` method called above runs when the promise is settled, doesn't matter successfully or not. So the loading indicator is always stopped before we go on. Please not that `finally` has no arguments, this outcome is passed through instead to the next suitable handler.

= 3 Promise Chaining

Result can be passed through the chain of `.then()` handlers, such as:

```javascript
new Promise((resolve, reject) => {
  setTimeout(() => resolve(1), 1000);
}).then(result => {
    alert(result);  // 1
    return 2 * result
}).then(result => {
    alert(result);  // 2
    return 2 * result
})
```

Every call to a `.then()` returns a new promise object, so that we can call the next `.then()` on it. When a handler returns a new value, it becomes the result of that promise. We can draw a workflow picture to figure it out:

#align(center)[
  #diagram(
    node-shape: rect,
    node-stroke: 0.5pt,
    node((0,0), `new Promise`, name: <new-promise>),
    node((0,1), `.then()`, name: <then-1>),
    node((0,2), `.then()`, name: <then-2>),
    node((0,3), `.then()`, name: <then-3>),

    edge(<new-promise>, <then-1>, "->", `resolve(1)`),
    edge(<then-1>, <then-2>, "->", `return 2`),
    edge(<then-2>, <then-3>, "->", `return 4`)
  )
]

If we did here is just adding several handlers to one promise, they don't pass the result to each other, their processes are independent. Like this:

```javascript
let promise = new Promise((resolve, reject) => {
  setTimeout(() => resolve(1), 1000);
});

promise.then(result => {
  alert(result);  // 1
  return 2 * result;
});

promise.then(result => {
  alert(result);  // 1
  return 2 * result;
});
```

Here's the picture, different from the promise chaining picture:

#align(center)[
  #diagram(
    node-shape: rect,
    node-stroke: 0.5pt,
    node((0,0), `new Promise`, name: <new-promise>),
    node((-1,1), `.then()`, name: <then-1>),
    node((1,1), `.then()`, name: <then-3>),
    node((0,1), `.then()`, name: <then-2>),
    node((0,0.4), `resolve(1)`, stroke: 0pt, name: <resolve>),

    edge(<resolve>, <then-1>, "->"),
    edge(<resolve>, <then-2>, "->"),
    edge(<resolve>, <then-3>, "->")
  )
]

From the promise chaining we can see that Promise can replace the pyramid of doom. We can refactor it using Promise as the code below:

```javascript
function loadScript(src) {
  return new Promise((resolve, reject) => {
    let script = document.createElement('script');
    script.src = src;

    script.onload = () => resolve(script);
    script.onerror = () => reject(new Error(`script load error for ${src}`));

    document.head.append(script);
  })
}

loadScript("1.js")
  .then(script => { return loadScript("2.js"); })
  .then(script => { return loadScript("3.js"); })
  .then(script => {
    one();
    two();
    three();
  });
```

Notice that the code of a promise executor and promise handlers has an "invisible `try..catch`" around it. If an exception happens, it gets caught and treated as a rejection. The two code snippets are the same:

```javascript
new Promise((resolve, reject) => {
  throw new Error("Here is an error");
})
.catch(alert);

new Promise((resolve, reject) => {
  reject(new Error("Here is an error"));
})
.catch(alert);
```

This happens not only in the executor function, but also in its handlers as well. If we `throw` inside a `.then()` handler, that will also be caught by the nearest error handler. And actually, this happens for all errors, not just those caused by the `throw` statement.

```javascript
new Promise((resolve, reject) => {
  resolve("Done");
})
.then((result) => {
  throw new Error("There is an error caused by Done");
})
.catch(alert);  // catch the error in handler

new Promise((resolve, reject) => {
  resolve("Done");
})
.then((result) => {
  notExistedFunction();
})
.catch(alert);  // catch the error not caused by throw statement
```

= Promise API

