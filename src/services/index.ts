import { TagService } from './tag.service';
import { TodoService } from './todo.service';
import { TopicService } from './topic.service';
import { Todo } from '../models/todo';

export const tagService = new TagService();
export const todoService = new TodoService(Todo);
export const topicService = new TopicService();
