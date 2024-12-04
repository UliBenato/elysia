// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
const {logger} = require("firebase-functions");
const {onRequest} = require("firebase-functions/v2/https");
const {onDocumentCreated} = require("firebase-functions/v2/firestore");

// The Firebase Admin SDK to access Firestore.
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");


initializeApp();

exports.notificarAlteracoesFirestore = functions.firestore
  .document("usuario/{usuarioID}/favoritas/{documentoId}")
  .onWrite(async (change, context) => {
    const documentId = context.params.documentId;

    if (!change.before.exists) {
      // Caso de novo documento criado
      console.log(`Novo documento criado: ${documentId}`);

      // Exemplo: Enviar mensagem de criação
      await enviarMensagem(`Novo documento criado: ${documentId}`);
    } else if (!change.after.exists) {
      // Caso de documento excluído
      console.log(`Documento excluído: ${documentId}`);

      // Exemplo: Enviar mensagem de exclusão
      await enviarMensagem(`Documento excluído: ${documentId}`);
    } else {
      // Caso de documento atualizado
      console.log(`Documento atualizado: ${documentId}`);

      // Exemplo: Enviar mensagem de atualização
      const antes = change.before.data();
      const depois = change.after.data();
      await enviarMensagem(
        `Documento atualizado: ${documentId}\nAntes: ${JSON.stringify(
          antes
        )}\nDepois: ${JSON.stringify(depois)}`
      );
    }
    return null;
  });

// Função auxiliar para enviar mensagens
async function enviarMensagem(mensagem) {
  try {
    console.log(`Enviando mensagem: ${mensagem}`);
    // Aqui você pode integrar com notificações, FCM, e-mail, etc.
  } catch (error) {
    console.error("Erro ao enviar mensagem:", error);
  }
}