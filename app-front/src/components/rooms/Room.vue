<template>
  <div class="">
    <h1>{{room.title}} </h1>
    <div id="chatbox">
      <div id="list_messages_-id-">

        <article class="chat-line" v-for="message in messages" :message="message">
          <span class="speaker">{{ message.sender_user }} </span>
          <span class="body">{{ message.content }}</span>
        </article>

      </div>
    </div>
    <div id="form_mssg" class="type_msg">
      <div class="input_msg_write">
        <input id="message_content" v-model="box_message" @keyup.enter="send_message" placeholder="Say something..." class="write_msg">
        <input id="message_room_id" type="hidden" value="-id-" >
        <button @click="send_message" ref="sendMessage" class="msg_send_btn">
        >
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
      messages: [],
    }
  },
  channels: {
        RoomChannel: {
            connected() {
                console.log('I am connected.');
            },
            received(data) {
              this.messages.push({sender_user: data['sender_user'], content: data['message']})
              var container = this.$el.querySelector("#list_messages_-id-")
              container.scrollTop = container.scrollHeight
            }
        }
  },
  created() {
    this.$http.get('http://localhost:3000/api/v1/rooms/' + this.room_id)
      .then(response => {
        if (response.status === 200) {
          this.messages = response.body.messages
          this.room = response.body.room
        }
      })
      .catch(error => {
        console.error(error)
      })
  },
  methods: {
    send_message: function(event){
        if(this.box_message != ""){
          this.$cable.perform({
            channel: 'RoomChannel',
            action: 'speak',
            data: {
              message: this.box_message,
              room_id: this.room_id,
            }
          });
        }
        event.preventDefault();
    }
  },
  mounted() {
      this.$cable.subscribe({ channel: 'RoomChannel' });
  }
}
</script>
