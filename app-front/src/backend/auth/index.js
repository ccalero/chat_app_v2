import router from '../../router'

// URL and endpoint constants
const API_URL = 'http://localhost:3000/'
const SIGNIN_URL = API_URL + 'signin/'
const SIGNUP_URL = API_URL + 'signup/'

export default {

  // User object will let us check authentication status
  user: {
    authenticated: false
  },

  // Send a request to the login URL and save the returned JWT
  login (context, creds, redirect) {
    context.$http.post(SIGNIN_URL, creds).then(data => {
      localStorage.setItem('token', data.body.csrf)
      localStorage.setItem('signedIn', true)
      this.user.authenticated = true
      if (redirect) {
        router.go(redirect)
      }

    }, response => {
      context.error = response
    });
  },

  signup (context, creds, redirect) {
    context.$http.post(SIGNUP_URL, creds).then(data => {
      localStorage.setItem('token', data.body.csrf)
      localStorage.setItem('signedIn', true)
      this.user.authenticated = true

      if (redirect) {
        router.go(redirect)
      }

    }, response => {
        context.error = response
      })
  },

  // To log out, we just need to remove the token
  logout () {
    localStorage.removeItem('token')
    localStorage.removeItem('signedIn')
    this.user.authenticated = false
  },

  checkAuth () {
    var jwt = localStorage.getItem('token')
    if (jwt) {
      this.user.authenticated = true
    } else {
      this.user.authenticated = false
    }
  },

  // The object to be passed as a header for authenticated requests
  getAuthHeader () {
    return {
      'Authorization': 'Bearer ' + localStorage.getItem('token')
    }
  }
}
