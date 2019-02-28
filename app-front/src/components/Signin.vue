<template>
  <div class="col-sm-4 col-sm-offset-4">
    <h2>Sign In</h2>
    <p>Log in to your account.</p>
    <div class="alert alert-danger" v-if="error">
      <p>{{ error }}</p>
    </div>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Enter your username" v-model="credentials.username" >
    </div>
    <button class="btn btn-primary" @click="signin()">Access</button>
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
      auth.login(this, credentials, 'secretquote')
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/rooms')
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/rooms')
      }
    }
  }
}
</script>
