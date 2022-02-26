<template>
  <div>
    <button
      type="button"
      class="btn btn-primary"
      data-toggle="modal"
      data-target="#staticBackdrop"
    >
      Launch demo modal
    </button>
    <div
      class="modal fade"
      id="staticBackdrop"
      data-backdrop="static"
      data-keyboard="false"
      tabindex="-1"
      aria-labelledby="staticBackdropLabel"
      aria-hidden="true"
    >
      <div id="myModal" class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
            <button
              type="button"
              class="close"
              data-dismiss="modal"
              aria-label="Close"
            >
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            Lorem ipsum dolor, sit amet consectetur adipisicing elit. Natus,
            dolorem quo, officiis repellat vitae odit in ipsum neque eveniet
            consectetur nobis quis autem debitis dolorum deserunt officia soluta
            illo laboriosam. Libero fuga error rerum optio enim dolorum nesciunt
            suscipit nisi voluptas id! Eius placeat quas eos perspiciatis,
            ratione dolore reprehenderit ut, quibusdam earum, error accusantium?
            Nostrum minus quasi, consequuntur culpa porro reprehenderit
            laboriosam sapiente rerum at eveniet placeat similique natus nisi ex
            illum necessitatibus eius delectus libero velit? Ducimus eius,
            consequatur quos omnis cupiditate placeat fuga? Officiis ratione
            sunt consequatur deleniti tenetur? Praesentium quaerat accusamus
            alias tempore magni pariatur odit similique voluptatem vitae
            explicabo fuga est obcaecati recusandae atque quidem aperiam, iure,
            sed nostrum eum. Labore sunt esse, totam ea alias necessitatibus
            quod.
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-dismiss="modal"
            >
              Close
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Modal",
  data() {
    return {};
  },
  mounted() {},
  method: {}
};
</script>

<style scoped></style>
