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
import PureVue (Ref (ref, readonly), Bindings, expose, set, get)

count :: Ref String Number
count = ref "count" 0

increment :: Ref String (Effect Unit)
increment = readonly "increment" $ do
  value <- get count
  set count (value + 1)

setup :: Effect Bindings
setup = expose count <> expose increment
</script>
```

Normally we use [ELM based](https://guide.elm-lang.org/architecture) design to deal with JS rendering libraries in PureScript, but I would like to try a new approach with something more similar to Vue Composition API + SFC.

The central idea is, instead of dealing with Vue as a side-effect free library, use a DSL to compute things and interact with components through the setup hook of Vue components. We are still studying the feasability and effort of doing this without bringing too much noise to the code.

The build process would be something like this:

```
vite build -> rollup purs build -> embed setup hook in the component options
```

The advantage of doing this way is that the boilerplate required to build Vue SFC with PureScript is almostly done ([with Vite](https://vitejs.dev)). It also keeps the API isomorphic with Vue allowing a much smaller learning path to PureScript.

## Differences from Vue

- PureScript only allows side-effects inside the `Effect` monad, for that reason we can only access or mutate a `Ref` value inside an `Effect` monad.
- Differently from Vue, we don't expect that you use `ref` ~only~ inside setup hook, our `ref` is just a type constructor and does not generate side-effects, the same applies for `readonly`.
- `expose` is a type constructor to create the respective bindings in the component instance

⚠️ This is a Work in Progress

Current Status: [POC planning](https://github.com/klarkc/pure-vue/issues/2)
<img src="https://static.scarf.sh/a.png?x-pxid=1909a3af-ecab-4ef6-ae35-7bc65052c246" />
