<template>
  <div class="">
    <Header/>
    <b-container>
      <b-row class="justify-content-md-center">
          <div id="app" style="width: 100%;">
            <router-view></router-view>
            <Footer/>
          </div>
      </b-row>
    </b-container>
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
