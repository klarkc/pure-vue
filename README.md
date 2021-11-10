# pure-vue
It's [Vue](https://vuejs.org/), it's [PureScript](https://www.purescript.org/). Simple as that.

```html
<!-- Main.vue -->
<template>
  <div>{{message}}</div>
<template>

<script setup lang="purescript">
import Prelude
import PureVue (ref)

message :: Ref
message = ref 'Hello World'
</script>
```

⚠️ This is a Work in Progress

Current Status: [POC planning](https://github.com/klarkc/pure-vue/issues/2)
