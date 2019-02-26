<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add a new room</h3>
    <form action="" @submit.prevent="addRoom">
      <div class="mb-6">
        <input class="input"
          autofocus autocomplete="off"
          placeholder="Type an arist name"
          v-model="newRoom.name" />
      </div>
      <input type="submit" value="Add Room" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green hover:bg-green-dark block w-full py-4 text-white items-center justify-center" />
    </form>

    <hr class="border border-grey-light my-6" />

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="room in rooms" :key="room.id" :room="room">

        <div class="flex items-center justify-between flex-wrap">
          <p class="block flex-1 font-mono font-semibold flex items-center ">
            <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 20 20" width="20" height="20"><title>music room</title><path d="M15.75 8l-3.74-3.75a3.99 3.99 0 0 1 6.82-3.08A4 4 0 0 1 15.75 8zm-13.9 7.3l9.2-9.19 2.83 2.83-9.2 9.2-2.82-2.84zm-1.4 2.83l2.11-2.12 1.42 1.42-2.12 2.12-1.42-1.42zM10 15l2-2v7h-2v-5z"></path></svg>
            {{ room.name }}
          </p>

          <button class="bg-tranparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded"
          @click.prevent="editRoom(room)">Edit</button>

          <button class="bg-transprent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red"
         @click.prevent="removeRoom(room)">Delete</button>
        </div>

        <div v-if="room == editedRoom">
          <form action="" @submit.prevent="updateRoom(room)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">
              <input class="input" v-model="room.name" />
              <input type="submit" value="Update" class=" my-2 bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 rounded cursor-pointer">
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Rooms',
  data () {
    return {
      rooms: [],
      newRoom: [],
      error: '',
      editedRoom: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/rooms')
        .then(response => { this.rooms = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addRoom () {
      const value = this.newRoom
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/rooms/', { room: { name: this.newRoom.name } })

        .then(response => {
          this.rooms.push(response.data)
          this.newRoom = ''
        })
        .catch(error => this.setError(error, 'Cannot create room'))
    },
    removeRoom (room) {
      this.$http.secured.delete(`/api/v1/rooms/${room.id}`)
        .then(response => {
          this.rooms.splice(this.rooms.indexOf(room), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete room'))
    },
    editRoom (room) {
      this.editedRoom = room
    },
    updateRoom (room) {
      this.editedRoom = ''
      this.$http.secured.patch(`/api/v1/rooms/${room.id}`, { room: { title: room.name } })
        .catch(error => this.setError(error, 'Cannot update room'))
    }
  }
}
</script>
