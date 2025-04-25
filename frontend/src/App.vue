<script setup>
  import { reactive, ref } from 'vue'

  import Message from './components/Message.vue'

  const messages = ref([
    {name: "Alice", timestamp: new Date(), text:"Hello!"},
    {name: "Peter", timestamp: new Date(), text: "Hi, how are you?"},
    {name: "Alice", timestamp: new Date(), text: "I\"m fine. Thanks!"},
  ])
  const input = ref("")

  function send() {
    messages.value.push({
      name: "Stefan",
      timestamp: new Date(),
      text: input.value,
    })
    input.value = ""
  }
</script>

<template>
  <main>
    <div id="messageBox">
      <Message v-for="message in messages" :message="message" />
    </div>
    <div id="inputBox">
      <textarea rows="3" v-model="input" @keyup.enter.ctrl="send"></textarea>
      <button @click="send">Send</button>
    </div>
  </main>
</template>

<style>
  main {
    display: flex;
    flex-direction: column;
    overflow: hidden;
    min-width: 100%;
  }

  #messageBox {
    flex: 1;
    max-width: 100%;
    padding: 15px;
    overflow-y: auto;
    background: #f9f9f9;
  }

  #inputBox {
    display: flex;
    padding: 3px;
    border-top: 1px solid #ccc;
    background: #f9f9f9;
  }

  #inputBox textarea {
    display: flex;
    width: 100%;
    padding: 7px;
    outline: none;
    border: 1px solid #ccc;
    border-radius: 5px;
    background: #f9f9f9;
  }

  #inputBox button {
    margin-left: 3px;
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    color: white;
    background: #007bdd;
  }

  #inputBox button:hover {
    background: #0056b3;
  }
</style>
