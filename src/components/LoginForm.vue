<template>
	<f7-page>
		<f7-navbar title="Dashboard" back-link="Back" sliding></f7-navbar>
		
	</f7-page>
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