<template>
  <div class="">
    <h1>Chat Room {{room_id}} <font-awesome-icon icon="coffee" /></h1>
    <div id="chatbox">
      <div id="list_messages_-id-">

        <article class="chat-line">
          <span class="speaker">User1: </span>
          <span class="body">Content</span>
        </article>
        <article class="chat-line">
          <span class="speaker">User1: </span>
          <span class="body">Content</span>
        </article>
        <article class="chat-line">
          <span class="speaker">User1: </span>
          <span class="body">Content</span>
        </article>

      </div>
    </div>
    <div id="form_mssg" class="type_msg">
      <div class="input_msg_write">
        <input id="message_content" v-model="box_message" @keyup.enter="send_message" placeholder="Say something..." class="write_msg">
        <input id="message_room_id" type="hidden" value="-id-" >
        <button @click="send_message" ref="sendMessage" class="msg_send_btn">
          <i class="fas fa-paper-plane"></i>
          <font-awesome-icon icon="paper-plane" />
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      room_id: this.$route.params.id,
      room: {},
      box_message: '',
    }
  },
  created() {
    this.$http.get('http://localhost:3000/api/v1/room/' + this.room_id)
      .then(response => {
        if (response.status === 200) {
          console.log(response)
        }
      })
      .catch(error => {
        console.error(error)
      })
  },
  methods: {
    send_message: function(event){
        if(this.box_message != ""){
          this.room_id = $('#message_room_id').val()
          App.room.speak({
            message: this.box_message,
            room_id: this.room_id,
          });
          this.box_message = '';
        }
        event.preventDefault();
      }
  }
}
</script>
