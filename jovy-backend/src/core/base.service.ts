import { EntityNotFoundError, EntityTarget, FindOptionsWhere, Repository } from 'typeorm';
import { db } from '../shared/db';
import { IBaseService } from '../abstractions/interfaces';

export abstract class BaseService<M> implements IBaseService<M> {
  protected readonly repository: Repository<M>;
  private readonly entity: EntityTarget<M>;

  constructor(entity: EntityTarget<M>) {
    this.repository = db.getRepository(entity);
    this.entity = entity;
  }

  async getAll(): Promise<M[]> {
    return this.repository.find();
  }

  async getOne(id = -1): Promise<M> {
    const entity: M | null = await this.repository.findOneBy({
      id,
    } as unknown as FindOptionsWhere<M>);

    if (!entity) {
      throw new EntityNotFoundError(this.entity, { id });
    }

    return entity;
  }

  async delete(id: number): Promise<number> {
    await this.repository.delete({ id } as unknown as FindOptionsWhere<M>);
    return id;
  }
}
