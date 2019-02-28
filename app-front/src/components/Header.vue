<template>
  <header class="navbar navbar-fixed-top navbar-inverse">
  <div class="container">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <ul class="nav navbar-nav navbar-right">
          <li><router-link to="/" class="link-grey px-2 no-underline" v-if="!signedIn()">Sign in</router-link> </li>
          <li><router-link to="/signup" class="link-grey px-2 no-underline" v-if="!signedIn()">Sign Up</router-link>  </li>
          <li><router-link to="/rooms" class="link-grey px-2 no-underline" v-if="signedIn()">Rooms</router-link>  </li>
          <li><a href="#" @click.prevent="signOut" class="link-grey px-2 no-underline" v-if="signedIn()">Sign out</a>  </li>
      </ul>
    </nav>
  </div>
</header>
</template>

<script>
import auth from '../backend/auth'
export default {
  name: 'Header',
  created () {
    this.signedIn()
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      auth.logout(this)
    }
  }
}
</script>
