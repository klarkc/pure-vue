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
import PureVue (Ref, ref, set)

count :: Ref Number
count = ref 0

increment :: Effect Unit
increment = do
  c <- count
  set count (c + 1)
</script>
```

⚠️ This is a Work in Progress

Current Status: [POC planning](https://github.com/klarkc/pure-vue/issues/2)
<img src="https://static.scarf.sh/a.png?x-pxid=1909a3af-ecab-4ef6-ae35-7bc65052c246" />
