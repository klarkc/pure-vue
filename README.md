# pure-vue
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
import PureVue (UnwrapRef (ref, readonly), expose, set, get)

count :: UnwrapRef String Int
count = ref "count" 0

increment :: UnwrapRef String (Effect Unit)
increment = readonly "increment" $ do
  value <- get count
  set count (value + 1)

setup :: Effect Unit
setup = do
  expose count
  expose increment
  pure unit
</script>
```

Normally we use [ELM based](https://guide.elm-lang.org/architecture) design to deal with JS rendering libraries in PureScript, but I would like to try a new approach with something more similar to Vue Composition API + SFC.

The central idea is, instead of dealing with Vue as a side-effect free library, use a DSL to compute things and interact with components through the setup hook of Vue components. We are still studying the feasability and effort of doing this without bringing too much noise to the code.

The build process would be something like this:

```
vite build -> SFC compiler -> rollup purs -> SFC compiler (embed setup hook) -> component JS module
```

The advantage of doing this way is that the boilerplate required to build Vue SFC with PureScript is almostly done ([with Vite](https://vitejs.dev)). It also keeps the API isomorphic with Vue allowing a much smaller learning path to PureScript.

## Differences from Vue

- PureScript only allows side-effects inside the `Effect` monad, for that reason we can only access or mutate a `Ref` value inside an `Effect` monad.
- Differently from Vue, we don't expect that you use `ref` inside setup hook, our `ref` is just a type constructor and does not generate side-effects, the same applies for `readonly`.
- `setup` does not receive arguments, to access their values use the respective functions: `useProps` and `useContext`.
- `setup` can only return a wrapped render function (TODO: render type) or `Unit`, to define the template bindings use `expose` function.
- `expose` is a effectful function which exposes a `UnwrapRef` to the [Vue template](https://vuejs.org/guide/essentials/template-syntax.html) as a [reactive](https://vuejs.org/guide/essentials/reactivity-fundamentals.html) `Ref (unwrap)` value, and returns it in the `Effect` monad.

## Differences from PureScript

- We don't define a module with `module` keyword, the module definition is set by the SFC compiler before purs compilation.
- The only exported function is `setup`, that is used as [setup hook](https://vuejs.org/api/composition-api-setup.html) in component options by the SFC compiler.

⚠️ This is a Work in Progress

Current Status: [POC planning](https://github.com/klarkc/pure-vue/issues/2)
<img src="https://static.scarf.sh/a.png?x-pxid=1909a3af-ecab-4ef6-ae35-7bc65052c246" />
