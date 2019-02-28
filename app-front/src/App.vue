<template>
  <div id="app">
    <Header/>
    <div class="container">
      <div class="content">
        <router-view></router-view>
        <Footer/>
      </div>
    </div>
  </div>
</template>

<script>

import Header from './components/parts/Header.vue'
import Footer from './components/parts/Footer.vue'

export default {
  name: 'App',
  components: {
    Header,
    Footer
  }
}
</script>

<style>
  @import './assets/styles/custom.scss';
</style>
