package dev.takeoutbackend;

import com.google.api.core.ApiFuture;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@EnableScheduling
@SpringBootApplication
@RestController
public class takeoutbackendApplication {
	Logger logger = LoggerFactory.getLogger(takeoutbackendApplication.class);
	public static void main(String[] args) {
		SpringApplication.run(takeoutBackendApplication.class, args);
	}

	@GetMapping("/")
	public String working(){
		return "Working backend";
	}
	@Scheduled(cron = "00 30 17 * * *")
	public void task() throws IOException, ExecutionException, InterruptedException {
		logger.info("doing task");
		GoogleCredentials credentials = GoogleCredentials.getApplicationDefault();
		FirebaseOptions options = new FirebaseOptions.Builder()
				.setCredentials(credentials)
				.setProjectId("##############")
				.build();
		FirebaseApp.initializeApp(options);
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<QuerySnapshot> query = db.collection("orders").get();
		QuerySnapshot querySnapshot = query.get();
		Map<String, Object> data = new HashMap<>();
		List<QueryDocumentSnapshot> documents = querySnapshot.getDocuments();
		for (QueryDocumentSnapshot document : documents) {
			if(document.getId().equals("placed")){
				data = document.getData();
			}




		}
		ApiFuture<WriteResult> addToStats = db.collection("statistics").document(getDate()).set(data);
		ApiFuture<WriteResult> delete = db.collection("orders").document("placed").set(new HashMap<>());
		System.out.println("Update time addToStats: " + addToStats.get().getUpdateTime());
		System.out.println("Update time delete : " + delete.get().getUpdateTime());
	}




	public static String getDate(){
		LocalDate date = LocalDate.now();
		return date.toString();
	}


}
