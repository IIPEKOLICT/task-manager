package taskmanager.backend.shared

import com.mongodb.ConnectionString
import org.litote.kmongo.coroutine.CoroutineClient
import org.litote.kmongo.coroutine.CoroutineDatabase
import org.litote.kmongo.coroutine.coroutine
import org.litote.kmongo.reactivestreams.KMongo

class DatabaseManager(private val configuration: Configuration) {

    private var client: CoroutineClient? = null
    private var database: CoroutineDatabase? = null

    fun init(): DatabaseManager {
        try {
            client = KMongo.createClient(ConnectionString(configuration.databaseUrl)).coroutine
            database = client!!.getDatabase(configuration.databaseName)
            return this
        } catch (e: Exception) {
            throw RuntimeException("Cannot connect to database")
        }
    }

    fun getDatabase(): CoroutineDatabase {
        return database ?: throw RuntimeException("Database unavailable")
    }
}