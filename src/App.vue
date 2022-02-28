<template>
  <div id="app">
    <div class="container-lg">
      <div class="row">
        <div class="col-auto mr-auto">
          <div class="input-group mb-3">
            <input
              v-model="inputSearch"
              @input="searchCountries"
              type="text"
              class="form-control searchInput"
              placeholder="Search"
            />
            <div class="input-group-append">
              <button
                @click="clearSearchText"
                class="btn searchClearTextBtn"
                type="button"
              >
                <i class="bi bi-x-circle-fill"></i>
              </button>
            </div>
          </div>
        </div>
      </div>
      <DataTable
        :countries="countriesForDisplay"
        :alert="alertText"
        @sortData="sortCountries"
      ></DataTable>
      <div class="my-5">
        <pagination
          :data="dataForPagination"
          @updateDataScope="getNowPageData"
        ></pagination>
      </div>
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
      countries: [],
      countriesForDisplay: [],
      countriesAfterFilter: [],
      sortBy: null,
      inputSearch: "",
      isSearching: false
    };
  },
  computed: {
    getIsSearching() {
      return this.inputSearch.length > 0;
    },
    dataForPagination() {
      return this.isSearching ? this.countriesAfterFilter : this.countries;
    },
    alertText() {
      if (this.isSearching && !this.countriesAfterFilter.length) {
        return "查無此國名，請重新輸入";
      } else {
        return "";
      }
    }
  },
  methods: {
    async fetchCountries() {
      const url = "https://restcountries.com/v3.1/all";

      await fetch(url, {})
        .then(res => res.json())
        .then(res => {
          this.countries = res;
        })
        .catch(err => {
          throw err;
        });
    },
    sortCountries(value) {
      this.sortBy = value || this.sortBy;
      this.dataForPagination.sort((current, next) => {
        const currentName = current.name.official.toUpperCase();
        const nextName = next.name.official.toUpperCase();

        if (currentName < nextName) {
          return this.sortBy === "ascending" ? -1 : 1;
        }

        if (currentName > nextName) {
          return this.sortBy === "ascending" ? 1 : -1;
        }
        return 0;
      });
    },
    getNowPageData(index) {
      const data = this.dataForPagination;
      this.countriesForDisplay = data.filter(
        (country, i) => i + 1 >= index.from && i + 1 <= index.end
      );
    },
    searchCountries() {
      if (this.inputSearch.length) {
        const keyword = this.inputSearch.replace(
          /([.?*+^$[\]\\(){}|-])/g,
          "\\$1"
        );
        const reg = new RegExp(keyword, "gi");

        this.isSearching = true;
        this.countriesAfterFilter = this.countries.filter(country =>
          reg.test(country.name.official)
        );
      } else {
        this.isSearching = false;
      }
      this.sortBy && this.sortCountries();
    },
    clearSearchText() {
      this.isSearching = false;
      this.inputSearch = "";
      this.sortBy && this.sortCountries();
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

<style lang="sass" scope>
.searchInput
  border-right-color: transparent
  &:focus
    border-color: #ced4da
    border-right-color: transparent
    box-shadow: 0 0 0 0 transparent

.searchClearTextBtn
  border-color: #ced4da;
  border-left-color: transparent
  &:focus
    box-shadow: 0 0 0 0 transparent
</style>
