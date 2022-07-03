import { ITagService } from '../abstractions/interfaces';
import { BaseService } from '../core/base.service';
import { Tag } from '../models';
import { In } from 'typeorm';
import { TagDto } from '../abstractions/dtos';
import { updateEntityFields } from '../shared/utils';
import { UPDATE_TAG_FIELDS } from '../constants/common';

export class TagService extends BaseService<Tag> implements ITagService {
  async getByIds(ids: number[] = []): Promise<Tag[]> {
    return this.repository.findBy({ id: In(ids) });
  }

  async create(dto: Partial<TagDto>): Promise<Tag> {
    const { name, color } = dto;
    return this.repository.save(this.repository.create({ name, color }));
  }

  async change(id: number, dto: Partial<TagDto>): Promise<Tag> {
    const tag: Tag = await this.getOne(id);
    return this.repository.save(updateEntityFields(tag, dto, UPDATE_TAG_FIELDS));
  }
}
