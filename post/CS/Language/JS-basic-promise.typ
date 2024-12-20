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

The function passed to `new Promise` is called the *executor*, when `new Promise` is created, the executor runs automatically. It contains the producing code which should eventually produce the result. Its arguments `resolve` and `reject` are callbacks provided by JavaScript