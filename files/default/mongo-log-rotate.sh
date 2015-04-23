#!/bin/bash
mongo admin --eval 'db.runCommand("logRotate")';
