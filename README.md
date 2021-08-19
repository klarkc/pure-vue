# pure-vue
It's Vue, it's PureScript. Simple as that.

```html
<!-- Main.vue -->
<template>
  <div>{{message}}</div>
<template>

<script language="purescript" setup>
module Main where

import Prelude
import PureVue (expose)

message = ref 'Hello World'

expose message
</script>
```
