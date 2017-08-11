import AuthService from './services/AuthService'
import OnboardingService from './services/OnboardingService'

import Vue from 'vue'
import VueResource from 'vue-resource'
import VueRouter from 'vue-router'
// import VueSocketio from 'vue-socket.io';

Vue.use(VueResource)
Vue.use(VueRouter)
// Vue.use(VueSocketio, process.env.SOCKET_ADDRESS);

Vue.http.options.credentials = true;

import Dashboard from './components/Dashboard'
import LoginForm from './components/LoginForm'
import Registration from './components/Registration.vue'

const routes = [
  { path: '/', redirect: () => {
    if (AuthService.user.authenticated){
      return '/dashboard';
    } else {
      return '/login';
    }
  }},
  { path: '/login', component: LoginForm },
  { path: '/signup', component: Registration },
  { path: '/dashboard', component: Dashboard }
]

const router = new VueRouter({
  routes,
  linkActiveClass: 'active'
});

export { router };
export default routes;

router.beforeEach((to, from, next) => {
  if (to.matched.some(route => route.meta.protected)){
    if (!AuthService.user.authenticated){
      console.log('Protected route requires login');
      next({
        path: '/login',
        query: {
          redirect: to.fullPath
        }
      });
    } else if (!OnboardingService.isOnboarded()){
      console.log('User requires onboarding');
      var route = OnboardingService.getOnboardingRoute();
      if (to.path.indexOf(route) !== -1 || to.matched.some(route => route.meta.bypassOnboarding)){
        next();
      } else {
        next({
          path: route,
          query: {
            redirect: to.fullPath
          }
        });
      }
    } else {
      next();
    }
  } else {
    next();
  }
});

/* export default [
  {
    path: '/about/',
    component: require('./assets/vue/pages/about.vue')
  },
  {
    path: '/form/',
    component: require('./assets/vue/pages/form.vue')
  },
  {
    path: '/signup/',
    component: require('./components/Registration/CodeForm.vue')
  },
  {
    path: '/dynamic-route/blog/:blogId/post/:postId/',
    component: require('./assets/vue/pages/dynamic-route.vue')
  }
] */
