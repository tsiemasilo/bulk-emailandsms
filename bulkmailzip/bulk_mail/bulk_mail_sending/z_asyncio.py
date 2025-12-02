#! /usr/bin/python3
import asyncio, random
import time

async def step_func(i_max:int = 10):
    await asyncio.sleep(i_max)
    return random.randint(1, i_max)
# end of step_func function

async def main():
    i_times = random.randint(1, 5)
    l_tasks = []
    for I in range(random.randint(1, 10)):
        l_tasks.append(asyncio.create_task(step_func(i_max=random.randint(1, 5))))
    # end of populating tasks list
    result = await asyncio.gather(*l_tasks)
    return result
# end of main function

if __name__=="__main__":
    f_start = time.time()
    l_result = asyncio.run(main())
    print(l_result)
    f_end = time.time()
    f_total = f_end-f_start
    i_total = sum(l_result)
    print(f"{f_total:.2f} seconds - while it waited total amount of {i_total} seconds in asynchronously executed processes")
# end of __name__ check