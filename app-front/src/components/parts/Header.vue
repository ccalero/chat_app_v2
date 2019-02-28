<template>
  <header class="navbar navbar-fixed-top navbar-inverse">
  <div class="container">
    <nav>
      <ul class="nav navbar-nav navbar-right">
          <li>
            <router-link :to="{ name: 'signin' }" v-if="!signedIn()">Sign in</router-link>
          </li>
          <li>
            <router-link :to="{ name: 'signup' }" v-if="!signedIn()">Sign Up</router-link>
          </li>
          <li>
            <router-link :to="{ name: 'rooms' }" v-if="signedIn()">Rooms</router-link>
          </li>
          <li>
            <a href="#" @click.prevent="signOut" v-if="signedIn()">Sign out</a>
          </li>
      </ul>
    </nav>
  </div>
</header>
</template>

<script>
import auth from '../../backend/auth'
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
