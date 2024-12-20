#import "/book.typ": book-page
#show: book-page.with(title: "Basic of TypeScript")

#align(center, text(17pt)[
  = Basic of TypeScript
])

= 1 Types

= 1.1 Introduction

JavaScript has three commonly used primitives: `string`, `number` and `boolean`, and each has a corresponding type in TypeScript:
- `string` represents string values like `"1234"`;
- `number` includes integer like `1`,`2`,etc. and float number like `1.234`;
- `boolean` simply is for the two values `true` and `false`.

TypeScript recommends using `string`, `number` and `boolean` rather than `String`, `Number` and `Boolean`.

To specify the type of an array like `["Huaier","AshGrey"]`, we should use syntax `string[]` or `Array<string>` to represent. The syntax `T<U>` is so called *generics*.

TypeScript also has a special type called `any`, we can use it whenever we don't want a particular type to cause typechecking errors. Just like this:

```typescript
let obj: any = { x: 0 };
obj.func();     // obj has a function property
obj();          // obj is a function
obj.bar = 100;  // obj has a number property
obj = "hello";  // obj becomes a string
```

`any` isn't type-checked, we should decrease its usage. To do this, we can use `noImplicitAny` to flag any implicit `any` as an error.

= 1.2 Type Annotations

When we declare a variable using `const`, `var` or `let`, we can optionally add a type explicitly specify the type of the variable:

```typescript
let partyName: string = "Dong";
```

TypeScript allows we to specify types of both the input and output values of functions. When a parameter has a type annotation, arguments of this function will be checked:

```typescript
function doILove(name: string) {
  if (name === "Huaier") {
    console.log("I love " + name.toUpperCase() + "!");
  } else {
    console.log("I don't love " + name.toUpperCase() + "!");
  }
}

doILove(5);
//       ^
// Argument of type 'number' is not assignable to parameter of type `string`.
```

We can also add return type annotations like this:

```typescript
function whoILove(): string {
  return "Huaier";
}
```

