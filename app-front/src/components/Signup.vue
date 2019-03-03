<template>
  <div class="text-center m-3">
    <h1>Sign Up</h1>
    <p>Create new account.</p>
    <b-form  @submit="signup" >
        <b-form-input
          id="username"
          type="text"
          v-model="credentials.username"
          required
          placeholder="Enter username" />
      </b-form-group>
      <b-form-text>
        Already have a user? <b-link :to="{ name: 'signin' }">Login now!</b-link>
      </b-form-text>
      <b-button class="m-3" type="submit" variant="primary">Create</b-button>
    </b-form>
    <br>
    <b-alert show variant="danger" v-if="error">{{ error }}</b-alert>
  </div>
</template>

<script>
import auth from '../backend/auth'
export default {
  name: 'Signup',
  data () {
    return {
      credentials: {
        username: ''
      },
      error: ''
    }
  },
  created () {
    this.checkedSignedIn()
  },
  updated () {
    this.checkedSignedIn()
  },
  methods: {
    signup () {
      var credentials = {
        username: this.credentials.username
      }
      auth.signup(this, credentials, 'rooms')
      this.error = this.credentials.username + " already exist"
    },
    checkedSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/rooms')
      }
    }
  }
}
</script>
