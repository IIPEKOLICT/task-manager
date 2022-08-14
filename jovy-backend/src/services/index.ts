import { TagService } from './tag.service';
import { TodoService } from './todo.service';
import { TopicService } from './topic.service';
import { Tag, Todo, Topic } from '../models';

export const tagService = new TagService(Tag);
export const todoService = new TodoService(Todo);
export const topicService = new TopicService(Topic);
