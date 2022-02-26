<template>
  <div id="app">
    <div class="container-lg">
      <div class="row">
        <div class="col-auto mr-auto">
          <div class="input-group">
            <input type="text" class="form-control" placeholder="Search" />
          </div>
        </div>
      </div>
      <DataTable :countries="countries"></DataTable>
      <Modal></Modal>
      <pagination></pagination>
    </div>
  </div>
</template>

<script>
import Pagination from "./components/Pagination.vue";
import DataTable from "./components/DataTable.vue";

export default {
  name: "App",
  components: { Pagination, DataTable },
  data() {
    return {
      countries: []
    };
  },
  methods: {
    async fetchCountries() {
      const url = "https://restcountries.com/v3.1/all";

      this.countries = await fetch(url, {}).then(res => res.json());
      console.log("countries :>> ", this.countries);
    }
  },
  mounted() {
    this.fetchCountries();
  }
};
</script>

<style lang="scss">
@import "~bootstrap/scss/bootstrap";
@import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css");

#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
