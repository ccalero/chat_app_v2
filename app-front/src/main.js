// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import VueResource from 'vue-resource'
import ActionCableVue from 'actioncable-vue';
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import VueChatScroll from 'vue-chat-scroll'
Vue.use(VueChatScroll)
Vue.use(BootstrapVue)
Vue.use(VueResource)

Vue.use(ActionCableVue, {
    debug: true,
    debugLevel: 'all',
    connectionUrl: 'ws://localhost:3000/api/v1/cable?token='+localStorage.getItem('token')
});

Vue.config.productionTip = false

new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
