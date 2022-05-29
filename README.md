# pure-vue
It's [Vue](https://vuejs.org/), it's [PureScript](https://www.purescript.org/). Simple as that.

```html
<!-- Main.vue -->
<template>
  <button @click="increment">
    Count is: {{ count }}
  </button>
<template>

<script setup lang="purescript">
import Prelude
import Effect (Effect)
import PureVue (Ref, ref, set, get)

count :: Ref Int
count = ref 0

increment :: Effect Unit
increment = do
  c <- get count
  set count (c + 1)
</script>
```

Normally we use [ELM based](https://guide.elm-lang.org/architecture) design to deal with JS rendering libraries in PureScript, but I would like to try a new approach with something more similar to Vue Composition API.

The central idea is, instead of dealing with Vue as a side-effect free library, use a DSL to compute things and interact with components through the setup hook of Vue components. We are still studying the feasability and effort of doing this without bringing too much noise to the code.

The build process would be something like this:

```
vite build > rollup purs build -> setup output
```

## Differences from Vue

PureScript only allows side-effects inside the Effect monad, for that reason we can only access or mutate a Ref inside an `Effect` function. The Single File Component compiler is turning all `Ref`'s into reactive state in the component setup hook.

⚠️ This is a Work in Progress

Current Status: [POC planning](https://github.com/klarkc/pure-vue/issues/2)
<img src="https://static.scarf.sh/a.png?x-pxid=1909a3af-ecab-4ef6-ae35-7bc65052c246" />
