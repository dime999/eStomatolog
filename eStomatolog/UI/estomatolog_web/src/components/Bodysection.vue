<template>
  <div class="welcome-section">
    <h1 class="title">Dobrodošli u eStomatolog!</h1>
    <p class="description">Otkrijte najbolje stomatološke ordinacije i upoznajte naše doktore.</p>
    <div class="buttons">
      <button class="button" @click="viewOffices">Pogledaj ordinacije</button>
      <span class="button-spacer"></span> <!-- Razmak između dugmadi -->
      <button class="button" @click="viewDoctors">Pogledaj doktore</button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'BodySection',
  methods: {
    viewOffices() {
      // Logika za prikaz ordinacija
    },
    viewDoctors() {
      // Logika za prikaz doktora
    }
  }
};
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap');

* {
  font-family: 'Roboto', sans-serif;
}

.welcome-section {
  text-align: center;
  margin-top: 350px;
}

.title {
  font-size: 4rem; 
  font-weight: bold;
  color: white;
  text-shadow: 2px 2px 0px black; 
}

.description {
  font-size: 2rem; 
  font-weight: bold;
  margin-bottom: 20px; 
  color: white;
  text-shadow: 2px 2px 0px black; 
}

.buttons {
  margin-top: 20px;
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
  text-shadow: 2px 2px 0px black; 
}

.button:hover {
  background-color: #0056b3;
}

.button-spacer {
  width: 20px; 
  display: inline-block;
}
</style>