{
  "program": "mempcy:\n.LBL2_0:\n  add r9 r9 4\n  mstore [r9,-4] r1\n  mload r1 [r9,-4]\n  mstore [r9,-3] r2\n  mload r2 [r9,-3]\n  mstore [r9,-2] r3\n  mload r3 [r9,-2]\n  mov r4 0\n  mstore [r9,-1] r4\n  jmp .LBL2_1\n.LBL2_1:\n  mload r4 [r9,-1]\n  gte r5 r3 r4\n  neq r6 r4 r3\n  and r5 r5 r6\n  cjmp r5 .LBL2_2\n  jmp .LBL2_3\n.LBL2_2:\n  mload r6 [r1,r4]\n  mstore [r2,r4] r6\n  add r5 r4 1\n  mstore [r9,-1] r5\n  jmp .LBL2_1\n.LBL2_3:\n  add r9 r9 -4\n  ret\ncond_bool:\n.LBL16_0:\n  add r9 r9 2\n  mstore [r9,-2] r1\n  mov r1 0\n  mstore [r9,-1] r1\n  mov r0 1\n  add r9 r9 -2\n  ret\nreturn_bool:\n.LBL17_0:\n  add r9 r9 1\n  mstore [r9,-1] r1\n  mload r0 [r9,-1]\n  add r9 r9 -1\n  ret\nbool_compare:\n.LBL18_0:\n  add r9 r9 3\n  mov r1 1\n  mstore [r9,-3] r1\n  mov r1 0\n  mstore [r9,-2] r1\n  mov r1 1\n  mstore [r9,-1] r1\n  mload r1 [r9,-3]\n  mload r2 [r9,-2]\n  neq r1 r1 r2\n  assert r1\n  mload r1 [r9,-3]\n  mload r2 [r9,-1]\n  eq r1 r1 r2\n  assert r1\n  add r9 r9 -3\n  ret\nfunction_dispatch:\n.LBL19_0:\n  add r9 r9 5\n  mstore [r9,-2] r9\n  mov r4 r1\n  mov r1 r2\n  mov r1 r3\n  mstore [r9,-3] r1\n  mload r1 [r9,-3]\n  eq r1 r4 1218183603\n  cjmp r1 .LBL19_2\n  eq r1 r4 2053569270\n  cjmp r1 .LBL19_3\n  eq r1 r4 527679565\n  cjmp r1 .LBL19_4\n  jmp .LBL19_1\n.LBL19_1:\n  ret\n.LBL19_2:\n  mload r1 [r1]\n  call cond_bool\n  mov r2 r0\n  mov r1 2\n.PROPHET19_0:\n  mov r0 psp\n  mload r0 [r0]\n  mov r1 r0\n  not r7 2\n  add r7 r7 1\n  add r1 r1 r7\n  mstore [r9,-4] r1\n  mload r1 [r9,-4]\n  mstore [r1] r2\n  mov r2 1\n  mstore [r1,+1] r2\n  mload r1 [r9,-4]\n  tstore r1 2\n  add r9 r9 -5\n  ret\n.LBL19_3:\n  mload r1 [r1]\n  call return_bool\n  mov r2 r0\n  mov r1 2\n.PROPHET19_1:\n  mov r0 psp\n  mload r0 [r0]\n  mov r1 r0\n  not r7 2\n  add r7 r7 1\n  add r1 r1 r7\n  mstore [r9,-5] r1\n  mload r1 [r9,-5]\n  mstore [r1] r2\n  mov r2 1\n  mstore [r1,+1] r2\n  mload r1 [r9,-5]\n  tstore r1 2\n  add r9 r9 -5\n  ret\n.LBL19_4:\n  call bool_compare\n  add r9 r9 -5\n  ret\nmain:\n.LBL20_0:\n  add r9 r9 2\n  mstore [r9,-2] r9\n  mov r1 13\n.PROPHET20_0:\n  mov r0 psp\n  mload r0 [r0]\n  mov r1 r0\n  mov r6 1\n  not r7 13\n  add r7 r7 1\n  add r2 r1 r7\n  tload r2 r6 13\n  mov r1 r2\n  mload r6 [r1]\n  mov r1 14\n.PROPHET20_1:\n  mov r0 psp\n  mload r0 [r0]\n  mov r1 r0\n  mov r2 1\n  not r7 14\n  add r7 r7 1\n  add r3 r1 r7\n  tload r3 r2 14\n  mov r1 r3\n  mload r2 [r1]\n  add r4 r2 14\n  mov r1 r4\n.PROPHET20_2:\n  mov r0 psp\n  mload r0 [r0]\n  mov r1 r0\n  mov r3 1\n  not r7 r4\n  add r7 r7 1\n  add r5 r1 r7\n  tload r5 r3 r4\n  mov r3 r5\n  mov r1 r6\n  call function_dispatch\n  add r9 r9 -2\n  end\n",
  "prophets": [
    {
      "label": ".PROPHET19_0",
      "code": "%{\n    entry() {\n        cid.addr = malloc(cid.len);\n    }\n%}",
      "inputs": [
        {
          "name": "cid.len",
          "length": 1,
          "is_ref": false,
          "is_input_output": false
        }
      ],
      "outputs": [
        {
          "name": "cid.addr",
          "length": 1,
          "is_ref": false,
          "is_input_output": false
        }
      ]
    },
    {
      "label": ".PROPHET19_1",
      "code": "%{\n    entry() {\n        cid.addr = malloc(cid.len);\n    }\n%}",
      "inputs": [
        {
          "name": "cid.len",
          "length": 1,
          "is_ref": false,
          "is_input_output": false
        }
      ],
      "outputs": [
        {
          "name": "cid.addr",
          "length": 1,
          "is_ref": false,
          "is_input_output": false
        }
      ]
    },
    {
      "label": ".PROPHET20_0",
      "code": "%{\n    entry() {\n        cid.addr = malloc(cid.len);\n    }\n%}",
      "inputs": [
        {
          "name": "cid.len",
          "length": 1,
          "is_ref": false,
          "is_input_output": false
        }
      ],
      "outputs": [
        {
          "name": "cid.addr",
          "length": 1,
          "is_ref": false,
          "is_input_output": false
        }
      ]
    },
    {
      "label": ".PROPHET20_1",
      "code": "%{\n    entry() {\n        cid.addr = malloc(cid.len);\n    }\n%}",
      "inputs": [
        {
          "name": "cid.len",
          "length": 1,
          "is_ref": false,
          "is_input_output": false
        }
      ],
      "outputs": [
        {
          "name": "cid.addr",
          "length": 1,
          "is_ref": false,
          "is_input_output": false
        }
      ]
    },
    {
      "label": ".PROPHET20_2",
      "code": "%{\n    entry() {\n        cid.addr = malloc(cid.len);\n    }\n%}",
      "inputs": [
        {
          "name": "cid.len",
          "length": 1,
          "is_ref": false,
          "is_input_output": false
        }
      ],
      "outputs": [
        {
          "name": "cid.addr",
          "length": 1,
          "is_ref": false,
          "is_input_output": false
        }
      ]
    }
  ]
}
