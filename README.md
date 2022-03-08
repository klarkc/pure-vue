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

## Differences from Vue

PureScript only allows side-effects inside the Effect monad, for that reason we can only access or mutate a Ref inside an `Effect` function. The Single File Component compiler is turning all `Ref`'s into reactive state in the component setup hook.

⚠️ This is a Work in Progress

Current Status: [POC planning](https://github.com/klarkc/pure-vue/issues/2)
<img src="https://static.scarf.sh/a.png?x-pxid=1909a3af-ecab-4ef6-ae35-7bc65052c246" />
