package taskmanager.backend.services.impl

import org.bson.types.ObjectId
import org.litote.kmongo.coroutine.CoroutineCollection
import org.litote.kmongo.eq
import org.litote.kmongo.set
import org.litote.kmongo.setTo
import taskmanager.backend.dtos.request.WorkDto
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.Work
import taskmanager.backend.services.WorkService
import taskmanager.backend.services.base.impl.CreatedByUserEntityServiceImpl
import java.text.SimpleDateFormat

class WorkServiceImpl(
    override val collection: CoroutineCollection<Work>
) : CreatedByUserEntityServiceImpl<Work>(collection, CollectionInfo.WORK), WorkService {

    override suspend fun getByTask(taskId: ObjectId): List<Work> {
        return collection.find(Work::task eq taskId).toList()
    }

    override suspend fun create(userId: ObjectId, taskId: ObjectId, dto: WorkDto): Work {
        val work = Work(
            createdBy = userId,
            task = taskId,
            description = dto.description,
            startDate = SimpleDateFormat().parse(dto.startDate),
            endDate = SimpleDateFormat().parse(dto.endDate)
        )

        collection.save(work)
        return work
    }

    override suspend fun updateById(id: ObjectId, dto: WorkDto): Work {
        return updateById(
            id,
            set(
                Work::description setTo dto.description,
                Work::startDate setTo SimpleDateFormat().parse(dto.startDate),
                Work::endDate setTo SimpleDateFormat().parse(dto.endDate)
            )
        )
    }

    override suspend fun deleteByTask(taskId: ObjectId) {
        collection.deleteMany(Work::task eq taskId)
    }
}