# pure-vue
It's [Vue](https://vuejs.org/), it's [PureScript](https://www.purescript.org/). Simple as that.

```html
<!-- Main.vue -->
<template>
  <div>{{message}}</div>
<template>

<script setup>
import Prelude
import PureVue (ref)

message = ref 'Hello World'
</script>
```
