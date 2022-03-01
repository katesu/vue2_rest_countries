<template>
  <div
    class="modal fade"
    id="countryDetail"
    data-backdrop="static"
    data-keyboard="false"
    tabindex="-1"
  >
    <div class="modal-dialog modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title text-left" id="countryDetailLabel">
            {{ heading }}
          </h5>
          <button type="button" class="close" data-dismiss="modal">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div v-if="!isEmptyData(country)" class="row flex-column">
            <div class="col">
              <img
                :src="country.flags.png"
                :alt="country.name.official"
                class="mb-4 img-fluid"
              />
            </div>
            <div class="col">
              <div class="row">
                <div class="col-6 text-left">
                  <p>
                    <span class="text-capitalize font-weight-bold"
                      >population:
                    </span>
                    {{ country.population }}
                  </p>
                  <p>
                    <span class="text-capitalize font-weight-bold"
                      >region: </span
                    >{{ country.region }}
                  </p>
                  <p>
                    <span class="text-capitalize font-weight-bold"
                      >sub region:
                    </span>
                    {{ country.subregion || "N/A" }}
                  </p>
                  <p>
                    <span class="text-capitalize font-weight-bold"
                      >latitude: </span
                    >{{ country.latlng[0] }}
                  </p>
                  <p>
                    <span class="text-capitalize font-weight-bold"
                      >longitude: </span
                    >{{ country.latlng[1] }}
                  </p>
                </div>
                <div class="col-6 text-left">
                  <p>
                    <span class="text-capitalize font-weight-bold"
                      >capital:
                    </span>
                    {{ capital }}
                  </p>
                  <p>
                    <span class="text-capitalize font-weight-bold"
                      >top level domain:
                    </span>
                    {{ tld }}
                  </p>
                  <p>
                    <span class="text-capitalize font-weight-bold"
                      >currencies:
                    </span>
                    {{ currencies }}
                  </p>
                  <p>
                    <span class="text-capitalize font-weight-bold"
                      >languages:
                    </span>
                    {{ languages }}
                  </p>
                </div>
              </div>
            </div>
            <div class="col text-left">
              <p>
                <span class="text-capitalize font-weight-bold">
                  border countries:
                </span>
                <template v-if="borders !== 'N/A'">
                  <a
                    v-for="(country, index) in borders"
                    :key="index"
                    @click.prevent="fetchCountry(country.ccn3)"
                    href="#"
                    class="d-inline-block p-1 mr-2 mb-1 alert-info  rounded"
                  >
                    {{ country.name }}
                  </a>
                </template>
                <template v-else>
                  <span>{{ borders }}</span>
                </template>
              </p>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">
            Close
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Modal",
  data() {
    return {
      country: {},
      borders: "N/A"
    };
  },
  computed: {
    heading() {
      return !this.isEmptyData(this.country)
        ? `${this.country.name.official}(${this.country.name.common})`
        : "";
    },
    capital() {
      if (this.country.capital) {
        return Object.values(this.country.capital).join(", ");
      } else {
        return "N/A";
      }
    },
    tld() {
      if (this.country.tld) {
        return Object.values(this.country.tld).join(", ");
      } else {
        return "N/A";
      }
    },
    currencies() {
      if (this.country.currencies) {
        return Object.entries(this.country.currencies)
          .map(([currency, content]) => {
            return `${content.name}(${content.symbol})`;
          })
          .join(", ");
      } else {
        return "N/A";
      }
    },
    languages() {
      if (this.country.languages) {
        return Object.values(this.country.languages).join(", ");
      } else {
        return "N/A";
      }
    }
  },
  methods: {
    isEmptyData(data) {
      return $.isEmptyObject(data);
    },
    async fetchBorders(codes) {
      const url = `https://restcountries.com/v3.1/alpha?codes=${codes}`;
      let data = {};
      await fetch(url, {})
        .then(res => res.json())
        .then(res => {
          data = res.map(country => ({
            name: country.name.common,
            ccn3: country.ccn3
          }));
        })
        .catch(err => {
          throw err;
        });

      return data;
    },
    async fetchCountry(ccn3) {
      const url = `https://restcountries.com/v3.1/alpha/${ccn3}`;

      await fetch(url, {})
        .then(res => res.json())
        .then(res => {
          this.country = res[0];
        })
        .catch(err => {
          throw err;
        });
    }
  },
  watch: {
    async country() {
      if (!this.isEmptyData(this.country) && this.country.borders) {
        this.borders = await this.fetchBorders(this.country.borders.join(","));
      } else {
        this.borders = "N/A";
      }
    }
  },
  mounted() {}
};
</script>

<style lang="sass" scoped>
  .modal-dialog
    @media screen and (max-width: 575px)
      width: 85%
      margin-left: auto
      margin-right: auto
</style>
