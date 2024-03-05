<template>
  <div class="welcome-section">
    <img src="../../public/logo.png" alt="Logo" class="logo">
    <h1 class="title">Dobrodošli u eStomatolog!</h1>
    <p class="description">Otkrijte najbolje stomatološke ordinacije i upoznajte naše doktore.</p>
    <div class="buttons">
      <button class="button" @click="viewOffices">Pogledaj ordinacije</button>
      <button class="button" @click="viewDoctors">Pogledaj doktore</button>
      <button class="button" @click="viewDoctors">Mobilna aplikacija</button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'BodySection',
  methods: {
    viewOffices() {
      document.getElementById('ordinacije-bar-container').scrollIntoView({ behavior: 'smooth' });
    },
    viewDoctors() {
      document.getElementById('doktori-bar-container').scrollIntoView({ behavior: 'smooth' });
    }
  }
};
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap');

* {
  font-family: 'Montserrat', sans-serif;
  box-sizing: border-box;
}

.welcome-section {
  text-align: center;
  margin-top: 100px;
  position: relative;
  z-index: 2;
  margin-bottom: 400px;
}


.title {
  font-size: 4rem;
  font-weight: bold;
  color: white;
  text-shadow: 4px 4px 0px rgba(0, 0, 0, 0.8);
  margin-bottom: 10px;
}

.description {
  font-size: 1.8rem;
  font-weight: bold;
  color: white;
  text-shadow: 4px 4px 0px rgba(0, 0, 0, 0.8);
  margin-bottom: 30px;
}

.buttons {
  display: flex;
  justify-content: center;
}

.button {
  padding: 15px 30px;
  font-size: 1.2rem;
  font-weight: bold;
  background-color: #007bff;
  color: white;
  border: 2px solid #007bff;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  margin: 0 10px;
}

.button:hover {
  background-color: #0056b3;
}

.logo {
  width: 250px;
  height: auto;
  margin-bottom: 20px;
  opacity: 0.9;
}
</style>
