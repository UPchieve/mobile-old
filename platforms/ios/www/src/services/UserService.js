import moment from 'moment'

import NetworkService from './NetworkService'
import AuthService from './AuthService'
import OnboardingService from './OnboardingService'

import {router} from '../router'

export default {
  getAuth(){
    return AuthService.user
  },
  getUser(){
    var auth = this.getAuth();
    if (auth.authenticated){
      return auth.data;
    } else {
      return {};
    }
  },
  validateBirthdate(){
    var user = this.getUser(),
        birthdate = user.birthdate;

    var m = moment(birthdate, 'MM/DD/YYYY');

    if (!m.isValid()){
      return 'Birthdate is invalid'
    }

    return true; // No validation errors
  },
  getOnboardingServiceInterest(){
    var user = this.getUser();
    return (user && user.onboardingServiceInterest) || [];
  },
  getOnboarding(){
    return OnboardingService.status;
  },
  setProfile(context, data, redirect){
    NetworkService.setProfile(context, data).then((res) => {
      console.log(res.data);
      if (res.data){
        AuthService.storeUser(res.data.user)
        context.msg = 'Set!'
      } else {
        throw new Error();
      }
      if (redirect){
        router.push(redirect)
      }
    }, (res) => {
      context.msg = 'Error occurred';
      console.log(res);
    })
  }
}
