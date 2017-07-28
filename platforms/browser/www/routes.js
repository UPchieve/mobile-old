// Pages
import Home from './src/components/Home.vue';
import LoginScreen from './src/components/LoginScreen.vue';
import AuthService from './src/services/AuthService'

export default [
  {
    path: '/home/',
    component: Home
  },
  {
    path: '/login-screen/',
    component: LoginScreen
  }
];
