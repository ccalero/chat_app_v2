<template>
  <div class="col-sm-4 col-sm-offset-4">
    <h2>Sign Up</h2>
    <p>Create new account.</p>
    <div class="alert alert-danger" v-if="error">
      <p>{{ error }}</p>
    </div>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Enter your username" v-model="credentials.username" >
    </div>
    <button class="btn btn-primary" @click="signup()">Access</button>
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
      // We need to pass the component's this context
      // to properly make use of http in the auth service
      auth.signup(this, credentials, 'secretquote')
      // this.$http.plain.post('/signup', { username: this.username })
      //   .then(response => this.signupSuccessful(response))
      //   .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }

      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/rooms')
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkedSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/rooms')
      }
    }
  }
}
</script>
