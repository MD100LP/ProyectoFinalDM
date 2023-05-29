import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

void sendEmailWithImage(String recipient, String subject, String body, String imagePath) {
  final String username = "alertdavidroom@outlook.es";
  final String password = "Anthonie30";

  Properties props = new Properties();
  props.put("mail.smtp.auth", "true");
  props.put("mail.smtp.starttls.enable", "true");
  props.put("mail.smtp.host", "smtp.office365.com");
  props.put("mail.smtp.port", "587");

  Session session = Session.getInstance(props,
    new javax.mail.Authenticator() {
      protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(username, password);
      }
    });

  try {
    Message message = new MimeMessage(session);
    message.setFrom(new InternetAddress(username));
    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
    message.setSubject(subject);

    // Crear parte de texto del correo
    MimeBodyPart textPart = new MimeBodyPart();
    textPart.setText(body);

    // Crear parte de imagen adjunta
    MimeBodyPart imagePart = new MimeBodyPart();
    DataSource source = new FileDataSource(imagePath);
    imagePart.setDataHandler(new DataHandler(source));
    imagePart.setFileName(source.getName());

    // Combinar partes del correo
    Multipart multipart = new MimeMultipart();
    multipart.addBodyPart(textPart);
    multipart.addBodyPart(imagePart);

    // Establecer contenido del mensaje como multipart
    message.setContent(multipart);

    // Enviar correo
    Transport.send(message);
    println("Correo enviado exitosamente.");
  } catch (MessagingException e) {
    println("Error al enviar el correo: " + e.getMessage());
  }
}
void setup() {
  // Resto del código de configuración de tu sketch
  sendEmailWithImage("mineradavid6@", "¡¡¡CUIDADO ALGUIEN HA ENTRADO A TU HABITACIÓN DAVID!!!", "ESTA PERSONA HA ENTRADO A TU HABITACIÓN", "C:\\Users\\davic\\OneDrive - Universidad Mariano Gálvez\\Escritorio\\Laboratorio Progra\\Final\\CodigoProcesingRespaldo\\Captura de pantalla 2023-05-25 171913.png");
}
