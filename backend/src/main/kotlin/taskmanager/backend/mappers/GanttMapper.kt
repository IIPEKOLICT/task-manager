package taskmanager.backend.mappers

import taskmanager.backend.dtos.response.GanttResponseDto
import taskmanager.backend.dtos.response.GanttResponseItemDto
import taskmanager.backend.dtos.response.TaskResponseDto
import kotlin.time.Duration
import kotlin.time.DurationUnit
import kotlin.time.ExperimentalTime

class GanttMapper {

    @OptIn(ExperimentalTime::class)
    fun convert(tasks: List<TaskResponseDto>): GanttResponseDto {
        val converted: MutableList<GanttResponseItemDto> = mutableListOf()
        val notConverted: MutableList<TaskResponseDto> = tasks.toMutableList()
        var allHours = 0

        while (notConverted.isNotEmpty()) {
            val filtered: List<TaskResponseDto> = notConverted.filter { notConvertedTask ->
                if (converted.isEmpty()) {
                    notConvertedTask.blockedBy.isEmpty()
                } else {
                    notConvertedTask.blockedBy.all { blockedById ->
                        converted.any { convertedTask ->
                            convertedTask.taskId == blockedById
                        }
                    }
                }
            }

            val convertedTasks: List<GanttResponseItemDto> = filtered.map { filteredTask ->
                val trackedHours: Int = Duration
                    .convert(
                        filteredTask.trackedTime.toDouble(),
                        DurationUnit.MILLISECONDS,
                        DurationUnit.HOURS
                    )
                    .toInt()

                val delayHours: Int = if (trackedHours > filteredTask.expectedHours) {
                    filteredTask.expectedHours - trackedHours
                } else {
                    0
                }

                val hours: Int = filteredTask.expectedHours + delayHours

                val startOffsetHours: Int = converted
                    .mapNotNull { convertedTask ->
                        if (filteredTask.blockedBy.contains(convertedTask.taskId)) {
                            convertedTask.endOffsetHours
                        } else {
                            null
                        }
                    }
                    .maxOrNull() ?: 0

                GanttResponseItemDto(
                    taskId = filteredTask._id,
                    taskColor = filteredTask.color,
                    taskName = filteredTask.title,
                    hours = hours,
                    startOffsetHours = startOffsetHours,
                    endOffsetHours = startOffsetHours + hours,
                )
            }

            allHours += convertedTasks.maxOfOrNull { it.hours } ?: 0

            converted.addAll(convertedTasks)
            notConverted.removeAll(filtered)
        }

        return GanttResponseDto(hours = allHours, items = converted)
    }
}