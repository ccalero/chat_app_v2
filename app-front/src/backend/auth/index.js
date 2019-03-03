import router from '../../router'

// URL and endpoint constants
const API_URL = 'http://localhost:3000/'
const SIGNIN_URL = API_URL + 'auth/login/'
const SIGNUP_URL = API_URL + 'auth/signup/'

export default {

  // User object will let us check authentication status
  user: {
    authenticated: false
  },

  // Send a request to the login URL and save the returned JWT
  login (context, creds, redirect) {
    context.$http.post(SIGNIN_URL, creds)
      .then(response => {
        if (response.status === 200) {
          localStorage.setItem('token', response.body.csrf)
          // Only used to change chat styles
          localStorage.setItem('username', response.body.username)
          localStorage.setItem('signedIn', true)
          this.user.authenticated = true
          if (redirect) {
            router.go(redirect)
          }
        }
      })
      .catch(error => {
        console.log(error)
      })
  },

  signup (context, creds, redirect) {
    context.$http.post(SIGNUP_URL, creds)
      .then(response => {
        if (response.status === 200) {
          localStorage.setItem('token', response.body.csrf)
          // Only used to change chat styles
          localStorage.setItem('username', response.body.username)
          localStorage.setItem('signedIn', true)
          this.user.authenticated = true
          if (redirect) {
            router.go(redirect)
          }
        }
      })
      .catch(error => {
        console.log(error)
      })
  },

  // To log out, we just need to remove the token
  logout () {
    localStorage.removeItem('token')
    localStorage.removeItem('signedIn')
    this.user.authenticated = false
    router.go('Signin')
  },

  checkAuth () {
    var jwt = localStorage.getItem('token')
    if (jwt) {
      this.user.authenticated = true
    } else {
      this.user.authenticated = false
    }
  },

  getAuthHeader () {
    return {
      'Authorization': 'Bearer ' + localStorage.getItem('token')
    }
  }
}
