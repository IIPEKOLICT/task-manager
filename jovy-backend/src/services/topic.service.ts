import { BaseService } from '../core/base.service';
import { Topic } from '../models';
import { ITopicService } from '../abstractions/interfaces';
import { TopicDto } from '../abstractions/dtos';
import { updateEntityFields } from '../shared/utils';
import { UPDATE_TOPIC_FIELDS } from '../constants/common';

export class TopicService extends BaseService<Topic> implements ITopicService {
  async create(dto: Partial<TopicDto>): Promise<Topic> {
    const { name, description } = dto;
    return this.repository.save(this.repository.create({ name, description }));
  }

  async change(id: number, dto: Partial<TopicDto>): Promise<Topic> {
    const topic: Topic = await this.getOne(id);
    return this.repository.save(updateEntityFields(topic, dto, UPDATE_TOPIC_FIELDS));
  }
}
