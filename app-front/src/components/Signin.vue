<template>
  <div class="text-center m-3">
    <h1>Sign In</h1>
    <p>Log in to your account.</p>
    <b-form  @submit="signin" >
        <b-form-input
          id="username"
          type="text"
          v-model="credentials.username"
          required
          placeholder="Enter username" />
      </b-form-group>
      <b-form-text>
        New user? <b-link :to="{ name: 'signup' }">Sign up now!</b-link>
      </b-form-text>
      <b-button class="m-3" type="submit" variant="primary">Access</b-button>
    </b-form>
    <br>
    <b-alert show variant="danger" v-if="error">{{ error }}</b-alert>
  </div>
</template>

<script>
import auth from '../backend/auth'
export default {
  name: 'Signin',
  data () {
    return {
      credentials: {
        username: ''
      },
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      var credentials = {
        username: this.credentials.username
      }
      auth.login(this, credentials, 'rooms')
      this.error = this.credentials.username + " does not exist"
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/rooms')
      }
    }
  }
}
</script>
