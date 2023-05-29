

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import processing.serial.*;
import javax.mail.Session;
import javax.mail.Message;
import processing.video.*;

miSerial = new Serial(this, Serial.list()[0], 9600);
//PRUEBA 
void keyPressed() {
  if (key == 's' || key == 'S') {
    cam.save("captura.png");s
    println("Captura guardada como captura.png");
  }
}
void stop() {
  cam.stop();
  super.stop();
}
void setup() {
 
  Serial.begin(9600);
   String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("No se encontraron cámaras disponibles.");
    exit();
  } else {
    println("Cámaras disponibles:");
    for (int i = 0; i < cameras.length; i++) {
      println(i + ": " + cameras[i]);
    }
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
}

void loop() {
  if (Serial.available() > 0) {
    int value = Serial.parseInt();
    if (value > 30) {
      enviarCorreo();
    }
  }
}
void draw() {
  if (cam.available()) {
    cam.read();
    image(cam, 0, 0);
  }
}

void enviarCorreo() {
  // CONFIGURACIÓN DEL PINCHE CORREO
  String remitente = "alertdavidroom@outlook.es";
  String password = "Anthonie30";
  String destinatario = "mineradavid6@gmail.com";
  String asunto = "ALGUIEN HA ENTRADO A TU HABITACIÓN DAVID!!!!";
  String mensaje = "¡ESTA PERSONA HA ENTRADO A TU HABITACIÓN, POR FAVOR TEN CUIDADO.";

  String host = "smtp.office365.com";
  int puerto = 587;

  Properties props = new Properties();
  props.put("mail.smtp.auth", "true");
  props.put("mail.smtp.starttls.enable", "true");
  props.put("mail.smtp.host", host);
  props.put("mail.smtp.port", puerto);

  Session session = Session.getInstance(props, new javax.mail.Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
      return new PasswordAuthentication(remitente, password);
    }
  });

  try {

    MimeMessage message = new MimeMessage(session);
    message.setFrom(new InternetAddress(remitente));
    message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario));
    message.setSubject(asunto);

   
    MimeBodyPart textPart = new MimeBodyPart();
    textPart.setText(mensaje);

    // CONFIGURACIÓN PARA LA IMAGEN 
    MimeBodyPart imagePart = new MimeBodyPart();
    String rutaImagen = "C:\\Users\\davic\\OneDrive - Universidad Mariano Gálvez\\Imágenes\\Álbum de la cámara\WIN_20220619_18_58_26_Pro.jpg"; // Ruta de la imagen a adjuntar
    DataSource fuenteImagen = new FileDataSource(rutaImagen);
    imagePart.setDataHandler(new DataHandler(fuenteImagen));
    imagePart.setFileName(fuenteImagen.getName());

    Multipart multipart = new MimeMultipart();
    multipart.addBodyPart(textPart);
    multipart.addBodyPart(imagePart);

    message.setContent(multipart);

    // ENVIO EL CORREO
    Transport.send(message);

    println("Correo enviado exitosamente.");
  } catch (MessagingException ex) {
    println("Error al enviar el correo: " + ex.getMessage());
  }
}













































































  //import java.util.*;
  //import javax.mail.*;
  //import javax.mail.internet.*;
  //miSerial = new Serial(this, Serial.list()[0], 9600);
  //Serial miSerial; // objeto para interactuar con el monitor serial
  //int valorSensor; // valor recibido por el monitor serial
  
  //// Credenciales del correo electrónico del remitente
  //String correoRemitente = "alertdavidroom@outlook.es";
  //String passwordRemitente = "Anthonie30";
  
  //// Configuración de propiedades SMTP
  //Properties props = new Properties();
  //props.put("mail.smtp.auth", "true");
  //props.put("mail.smtp.starttls.enable", "true");
  //props.put("mail.smtp.host", "smtp-mail.outlook.com");
  //props.put("mail.smtp.port", "587");
  
  //// Autenticación del remitente
  //Session session = Session.getInstance(props, new javax.mail.Authenticator() {
  //  protected PasswordAuthentication getPasswordAuthentication() {
  //    return new PasswordAuthentication(correoRemitente, passwordRemitente);
  //  }
  //);}
  
  
  //void draw() {
  //  // Leer datos del monitor serial
  //  if (miSerial.available() > 0) {
  //    valorSensor = miSerial.read();
  //    println("Valor recibido del monitor serial: " + valorSensor);
      
  //    // Enviar correo electrónico si el valor es mayor a 30
  //    if (valorSensor > 30) {
  //      enviarCorreo();
  //    }
  //  }
  //}
  
  //void enviarCorreo() {
  //  try {
  //    // Creación del mensaje de correo electrónico
  //    Message mensaje = new MimeMessage(session);
  //    mensaje.setFrom(new InternetAddress(correoRemitente));
  //    mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse("mineradavid6@gmail.com"));
  //    mensaje.setSubject("Valor del monitor serial mayor a 30");
  //    mensaje.setText("El valor del monitor serial es mayor a 30.");
      
  //    // Enviar mensaje
  //    Transport.send(mensaje);
  //    println("El mensaje ha sido enviado.");
      
  //  } catch (MessagingException e) {
  //    println("Error al enviar el mensaje: " + e.getMessage());
  //  }
  //}
  
  
  













































//import org.apache.commons.mail.*;
//import javax.mail.*;
//import javax.mail.internet.*;
//import processing.serial.*;


//import javax.mail.*;
//import javax.mail.internet.*;
//import java.util.Properties;
//import javax.mail.Session;
//import javax.mail.Message;
//PImage img;


//Serial miSerial;
//int valorSensor;

//void setup() {
//  //Monitor serial 
  
//  miSerial = new Serial(this, Serial.list()[0], 9600);
  
//  img = loadImage("camara1.png");
//  DataHandler dh = new DataHandler(new FileDataSource("camara1.png"));
//  size(800,800);
//  // Configurar las propiedades de la sesión de correo
//  Properties props = new Properties();
//  props.put("mail.smtp.host", "smtp.office365.com");
//  props.put("mail.smtp.port", "587");
//  props.put("mail.smtp.auth", "true");
//  props.put("mail.smtp.starttls.enable", "true");
  
//  // Crear una sesión de correo electrónico con tus credenciales de Outlook
//  Session session = Session.getInstance(props,
//    new javax.mail.Authenticator() {
//      protected PasswordAuthentication getPasswordAuthentication() {
//        return new PasswordAuthentication("alertdavidroom@outlook.es", "Anthonie30");
//      }
//    });

 
//}
//void draw(){
//   if (miSerial.available() > 0){
//   valorSensor = miSerial.read();
//   println("Valor recibido del monitor serial: "+valorSensor);
   
//   if(valorSensor>30){
//      mandarCorreo();   
//   }
// }
//}

//void mandarCorreo(){
    
// try {
//    // Crear un mensaje de correo electrónico
    
//    Message message = new MimeMessage(session);
//    message.setFrom(new InternetAddress("alertdavidroom@outlook.es"));
//    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse ("mineradavid6@gmail.com"));
//    message.setSubject("Asunto del correo: Prueba");
//    message.setText("Prueba123 que entraron a mi cuarto");
//    message.setText("Envido desde processing");
//    //Enviar imagen captada en camara
//     MimeBodyPart messageBodyPart = new MimeBodyPart();
//    messageBodyPart.setDataHandler(dh);
//    messageBodyPart.setFileName("camara1.png");
//    Multipart multipart = new MimeMultipart();
//    multipart.addBodyPart(messageBodyPart);
//    message.setContent(multipart);
//    // Enviar el mensaje de correo electrónico
//    Transport.send(message);
//    //

//    System.out.println("El correo electrónico ha sido enviado exitosamente.");

//  } catch (MessagingException e) {
//    throw new RuntimeException(e);
//  }

//}





//import javax.activation.*;
//void setup() {
//  // Crea un objeto Email con las credenciales de tu cuenta de correo electrónico
//  Email email = new SimpleEmail();
//  //email.setHostName("smtp.gmail.com");
//  email.setHostName("gmail.com");
//  email.setSmtpPort(465);
//  email.setAuthenticator(new DefaultAuthenticator("alertdavidroom@gmail.com", "Anthonie30"));
//  email.setSSLOnConnect(true);
  
//  try {
//    // Especifica la dirección de correo electrónico de destino, el asunto y el cuerpo del mensaje
//    email.setFrom("alertdavidroom@gmail.com");
//    email.setSubject("Prueba de correo electrónico");
//    email.setMsg("Este es un correo de prueba enviado desde Processing.");
//    email.addTo("davidminera30@gmail.com");
    
//    // Envía el correo electrónico
//    email.send();
//    println("Correo electrónico enviado.");
//  } catch (EmailException e) {
//    println("Error al enviar el correo electrónico: " + e.getMessage());
//  }
  
//  // Sale del programa
//  exit();
//}


//import com.twilio.Twilio;
//import com.twilio.type.PhoneNumber;
//import com.twilio.whatsapp.Message;
//import com.twilio.whatsapp.MessageCreator;

//void setup() {
//  Twilio.init("ACCOUNT_SID", "AUTH_TOKEN");

//  String from = "whatsapp:++15076288214"; // Número de WhatsApp de Twilio
//  String to = "whatsapp:+50254931711"; // Número de destino de WhatsApp
//  String message = "¡Hola desde Processing!"; // Mensaje a enviar

//  MessageCreator creator = Message.creator(new PhoneNumber(to), new PhoneNumber(from), message);
//  creator.create();
//}
