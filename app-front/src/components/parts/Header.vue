<template>
    <b-navbar type="dark" variant="dark">
      <b-navbar-brand>Chat App</b-navbar-brand>
      <b-navbar-nav v-if="signedIn()">
        <b-nav-item :to="{ name: 'rooms' }">Rooms</b-nav-item>
        <b-nav-item href="#" @click.prevent="signOut">Sign out</b-nav-item>
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
