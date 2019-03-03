<template>
    <b-navbar type="dark" variant="dark">
      <b-navbar-nav>
        <b-nav-item :to="{ name: 'signin' }" v-if="!signedIn()">Sign in</b-nav-item>
        <b-nav-item :to="{ name: 'signup' }" v-if="!signedIn()">Sign Up</b-nav-item>
        <b-nav-item :to="{ name: 'rooms' }" v-if="signedIn()">Rooms</b-nav-item>
        <b-nav-item href="#" @click.prevent="signOut" v-if="signedIn()" right>Sign out</b-nav-item>
    </b-navbar-nav>
  </b-navbar>
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
