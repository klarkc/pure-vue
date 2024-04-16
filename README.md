# pure-vue
[![GitHub milestone](https://img.shields.io/github/milestones/progress-percent/klarkc/pure-vue/1)](https://github.com/users/klarkc/projects/1/views/2)
[![Backers](https://img.shields.io/badge/backers-0-yellow)](https://handle.me/walkerleite)

It's [Vue](https://vuejs.org/), it's [PureScript](https://www.purescript.org/). Simple as that.

```html
<!-- Main.vue -->
<template>
  <button @click="increment">
    Count is: {{ count }}
  </button>
<template>

<script lang="purescript">
import Prelude
import Effect (Effect)
import Effect.Console (log) as Effect.Console
import PureVue (UnwrapRef, ref, readonly, expose, set, get, watch)

count :: UnwrapRef "count" Int
count = ref 0

increment :: UnwrapRef "increment" (Effect Unit)
increment = readonly $ do
  value <- get count
  set count (value + 1)
           
log :: Effect Unit
log = do
  value <- get count
  Effect.Console.log ("count changed to: " <> value)

setup :: Effect Unit
setup = do
  expose count
  expose increment
  discard $ watch count log
</script>
```

Normally we use [ELM based](https://guide.elm-lang.org/architecture) design to deal with JS rendering libraries in PureScript, but I would like to try a new approach with something more similar to Vue Composition API + SFC.

The central idea is, instead of dealing with Vue as a side-effect free library, use a DSL to compute things and interact with components through the setup hook of Vue components. We are still studying the feasability and effort of doing this without bringing too much noise to the code.

The build process would be something like this:

```
vite build -> SFC compiler -> PureVue (PS -> JS) -> SFC compiler (embed setup hook) -> component JS module
```

The advantage of doing this way is that the boilerplate required to build Vue SFC with PureScript is almostly done ([with Vite](https://vitejs.dev)). It also keeps the API isomorphic with Vue allowing a much smaller learning path to PureScript.

## Differences from Vue

- PureScript only allows side-effects inside the `Effect` monad, for that reason we can only access or mutate a `Ref` value inside an `Effect` monad.
- Differently from Vue, we don't expect that you use `ref` inside setup hook, our `ref` is just a type constructor and does not generate side-effects, the same applies for `readonly`.
- To reduce boilerplate on PureScript side, all functions on the Vue side that receives a `Ref`, on PureScript side, receives a corresponding `UnwrapRef`.
- `setup` does not receive arguments, to access their values use the respective functions: `useProps` and `useContext`.
- `setup` can only return a wrapped render function (TODO: render type) or `Unit`, to define the template bindings use `expose` function.
- `expose` is a effectful function which exposes a `UnwrapRef` to the [Vue template](https://vuejs.org/guide/essentials/template-syntax.html) as a [reactive](https://vuejs.org/guide/essentials/reactivity-fundamentals.html) `Ref (unwrap)` value.

## Differences from PureScript

- We don't define a module with `module` keyword, the module definition is set by the SFC compiler before purs compilation.
- The only exported function is `setup`, that is used as [setup hook](https://vuejs.org/api/composition-api-setup.html) in component options by the SFC compiler.
- 
## Why I've Given Up on This Project

There are a few reasons why I'm giving up on this project, after a [very insightful discussion on PureScript Discord](https://discord.com/channels/864614189094928394/865401680497737758/1212131706740412416):

1. I realized the complexity of building a type-checking solution. Besides being outside the scope of the proof of concept, it would be essential to make this solution usable in any sense, and I don't have any expertise in this topic.
2. To have type-checking in place, we would need to fork `@vue/language-core` to have a `vue-purs` alternative akin to `vue-tsc`. This would demand even a fork of the Vue language server itself.
3. `@vue/language-core` is currently entangled with TypeScript ([see](https://github.com/vuejs/language-tools/blob/16635035be40be98e1f724f69cedbec50fcc295c/packages/language-core/lib/parsers/scriptRanges.ts#L2)).
