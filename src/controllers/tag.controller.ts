import { Body, Controller, Delete, Get, Param, Patch, Post } from 'jovy';
import { EndPoint, Selector } from '../constants/enums';
import { Tag } from '../models';
import { tagService, todoService } from '../services';
import { DeleteDto, TagDto } from '../abstractions/dtos';

@Controller(EndPoint.TAGS)
export class TagController {
  @Get()
  async getAll(): Promise<Tag[]> {
    return tagService.getAll();
  }

  @Get(Selector.ID)
  async getOne(@Param('id') id: string): Promise<Tag> {
    return tagService.getOne(+id);
  }

  @Post()
  async create(@Body() dto: Partial<TagDto>): Promise<Tag> {
    return tagService.create(dto);
  }

  @Patch(Selector.ID)
  async change(@Param('id') id: string, @Body() dto: Partial<TagDto>): Promise<Tag> {
    return tagService.change(+id, dto);
  }

  @Delete(Selector.ID)
  async delete(@Param('id') id: string): Promise<DeleteDto> {
    await todoService.removeTag(+id);
    return { id: await tagService.delete(+id) };
  }
}
