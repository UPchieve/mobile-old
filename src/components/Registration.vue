<template>
    <code-form v-if="!validRegistrationCode"></code-form>
    <signup-form v-else></signup-form>
</template>

<script>
import CodeForm from './Registration/CodeForm';
import SignupForm from './Registration/SignupForm';

import RegistrationService from '../services/RegistrationService';

export default {
  components: {
    CodeForm,
    SignupForm
  },
  data(){
    return RegistrationService.data;
  }
}
</script>