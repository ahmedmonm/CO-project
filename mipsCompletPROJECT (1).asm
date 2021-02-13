.data
menu : .asciiz "\nSelect your function:\n\n 1. count_char_occurence\n2.count_word_occurence \n3. find_and_replace word\n4.search for word/chrater \nChoice: "

#case1
    command1:   .asciiz "Please enter a sentence "
    command2:   .asciiz "Please enter a character "
    #count:      .word 1
    sentence:   .space 100
    character:  .space 4
    command3:   .asciiz " Character "
    command4:   .asciiz " appears in the sentence "
    command5:   .asciiz " times. "
    
#case2
    msg: .asciiz "Enter the string \n"
    msg2: .asciiz "Enter word want to search occurences  :"
    string:.space 100
    word:.space 4
    size:   .asciiz "word "
    outputmsg1:   .asciiz " appears in the sentence "
    outputmsg2:   .asciiz " times. "
    output: .asciiz " the total occurrences is :"
    
#case3
    para:       .space 1000                     # Pre allocate space for the input paragraph
    copypara:   .space 1000                     #copy the original paragraph
    input:      .space 30                       # Pre allocate space for the input word
    copy:       .space 30                       # Duplicate string to store the word
    replace:    .space 30                       # The alternative word
    replacemsg: .asciiz "Enter the word you want to replace with the word you want to find: \n" 
    ask:        .asciiz "Enter the paragraph:\n"            # Display msg to enter the paragraph
    askwd:      .asciiz "Enter the word you want to find:\n"    # Display msg to enter the word you want to find
    nomatch:    .asciiz "Sorry...The word is not present in the given paragraph.\n"
    match:      .asciiz "Number of times the word present in the paragraph is :-\n"
    line:       .asciiz "\n"
    origpar:    .asciiz "\nTHE ORIGINAL PARAGRAPH IS:- \n-----------------------------------------------------------------------------\n"
    result:     .asciiz "-----------------------------------------------------------------------------\nTHE MODIFIED PARAGRAPH IS:-\n-----------------------------------------------------------------------------\n"
    error:      .asciiz "Sorry...The word you you want to replace with is not the same size of the word you want to find.\n"

#case5
    msg5: .asciiz "Enter the string \n"
    msg25: .asciiz "Enter word/chracter want to find :"
    string5:.space 100
    word5:.space 4
    searchmsg1:   .asciiz "word "
    searchmsg2:   .asciiz "appears in the sentence "
    searchmsg3:   .asciiz "times. "
    searchmsg4:   .asciiz "It appeared in index : "
    new_line:   .asciiz "\n"

    output5: .asciiz " the total occurrences is :"


.text
main:
loop2: 
#show menu
li $v0,4 #system call for print string
la $a0,menu 
syscall

# get choice 
li $v0,5 # system call for get integer 
syscall

move $t0,$v0 #move choice from v0 to t0 ( t0 = choice)

beqz $t0,Exitprogram # if t0==0
#switch cases 
#make the register s0 =1 to compare it with choice
addi $s0,$zero,1
#case 1 condition 
bne $t0,$s0,c2_cond #if t0 != s0 goto case condition 2 
j c1_body
#case 2 condition 
c2_cond: 
addi $s0,$zero,2 #s0=2
bne $t0,$s0,c3_cond #if t0!= s0 goto case condition 3
j c2_body
#case 3 condition 
c3_cond:
addi $s0,$zero,3 #s0=3
bne $t0,$s0,c4_cond #if t0!= s0 goto case condition 4
j c3_body 

#case 4 condition 
c4_cond:
addi $s0,$zero,4#s0=4
bne $t0,$s0,Exit #if t0!= s0 goto Exit
j c4_body

c1_body:
    li $t0, 100 #end var for loop
    li $t1, 0   #start var for loop
    li $t2, 0   #number of occurences

    la $a0, command1    #print 'please enter sentence'
    li $v0, 4
    syscall


    la $a0, sentence    #input sentence
    li $a1, 100
    li $v0, 8
    syscall

    la $a0, command2    #print 'please enter char'
    li $v0, 4
    syscall

    la $a0, character   #input character
    li $a1, 4
    li $v0, 8
    syscall

    la $s0, character
    lb $s1, ($s0)
    la $t3, sentence
    lb $a2,0($t3) #gets first char of sentence

loop:
    beq $a2, $zero, end5     #once reach end of char array, prints result
    beq $a2, $s1, something #if the char within sentence == comparing char
    addi $t3, $t3, 1
    lb $a2,($t3)        
    j loop

something:              
    addi $t2, $t2, 1        #increments number of occurences of char 
     addi $a2, $a2, 1
    j loop
end5:
    la $a0, command3
    li $v0, 4
    syscall
    la $a0, command3
    li $v0, 4
    syscall

    la $a0, character
    li $v0, 11
    syscall

    la $a0, command4
    li $v0, 4
    syscall

    la $a0 sentence
    li $v0, 4
    syscall

    #la $a0, $t2
    li $v0, 1
    move $a0, $t2
    syscall

    la $a0, command5
    li $v0, 4
    syscall
    
    j Exit #go to Exit
 
 c2_body:
    la $a0, msg    #print 'please enter sentence'
    li $v0, 4
    syscall


    la $a0, string    #input sentence
    li $a1, 100
    li $v0, 8
    syscall
   
    la $a0, msg2    #print 'please enter char'
    li $v0, 4
    syscall

    la $a0, word   #input character
    li $a3, 8
    li $v0, 8
    syscall
    
    la $s0, word
    lb $a2, ($s0) # first char in word
    la $s1, string
    lb $a0, ($s1) #first char in string 
    
    li $a3,0  #k=0
    li  $a1,0 #n=0
   word_len1:
       beq $a2, $zero,end1
       addi $a3,$a3,1
       addi $s0,$s0,1
       lb $a2,($s0)
       j word_len1
    end1: 
       sub $a3,$a3,1
       #sub $a3,$a3,1 #word_len
   str_len1:
       beq $a0, $zero,end4
       addi $a1,$a1,1
       addi $s1,$s1,1
       lb $a0,($s1)
       j str_len1
       end4: 
       sub $a1,$a1,1 #str_len
       
     la $s0, word
     lb $a2, ($s0) # first char in word
     la $s1, string
     lb $a0, ($s1) #first char in string 
count_word_occurences1:
	li	$v1, 0		# count
	li	$t0, 0		# i
	sub	$t1, $a1, $a3	# str_len - word_len
loop_i1:
	bgt 	$t0, $t1, exit	 #i>str_len - word_len
         li	$t2, 1	  	# found = 1
	 li	$t3, 0		# j=0
	
loop_j1:
	bge	$t3, $a3, exit_j1  #j>word_len
	add	$t4, $s1, $t0	# &str[i]  
	add	$t4, $t4, $t3	# &str[i+j]
	lb	$t4, 0($t4)	# str[i+j]
	add	$t5, $s0, $t3	# &word[j]
	lb	$t5, 0($t5)	# word[j]
	beq 	$t4, $t5, skip1
	li	$t2, 0		# found = 0
	j	exit_j1		# break
	

skip1:
	add	$t3, $t3, 1	# j ++
	j	loop_j1
	

exit_j1:
	beq	$t2, $0, skip3 #found==1
	add	$v1, $v1, 1	# count ++
skip3:
	add	$t0, $t0, 1	# i ++
	j	loop_i1

exit:
       #li $v1, 10	
       la $a0, size
       li $v0, 4
       syscall
       la $a0, word
       li $v0, 11
       syscall
       la $a0, outputmsg1
       li $v0, 4
       syscall

      la $a0, string
      li $v0, 4
      syscall
    
      li $v0, 1
      move $a0, $v1
      syscall

     la $a0, outputmsg2
     li $v0, 4
     syscall
     j Exit #go to Exit 
 
 
 c3_body:
 
# print the msg to enter the paragraph
    li $v0,4    
    la $a0,ask
    syscall



# Take the input paragraph
    la $a0,para
    li $a1,1000                 # allocate 1000 empty space
    li $v0,8
    syscall

    la $s5,copypara                 #load the the base address of the copypara




# print the msg to enter the word you want to find
    li $v0,4
    la $a0,askwd
    syscall
    
# take the word
    la $a0,input
    li $a2,30                   # create 30 empty spaces
    li $v0,8
    syscall
    move $s2,$a0                # move the adress of the input word from $a0 to $s2



# print the msg to enter the word you want to replace
    li $v0,4
    la $a0,replacemsg
    syscall



# take the word
    la $a0,replace
    li $a2,30
    li $v0,8
    syscall
    move $s4,$a0                # the alternative word address is on $s4

# Assign the recquired ascii values in registers and load the  base address of the recquired variables in their respective registers
    li $t5,10               # ascii value of new line
    la $s0,copy             # loading the addresses of copy of extracted word and the original para
    la $s1,para             # loading the address of the paragraph
    li $t4,1                # count the number of letters present in input word
    li $t7,0                # count the number of times the word present



# Count the number of letters prsent in the input word
    lb $t6,0($s2)               
    count:
        beq $t6,10,countreplace
        addiu $s2,$s2,1
        lb $t6,0($s2)
        addi $t4,$t4,1
    j count



# This block count the number of letters present in replace word
    countreplace :
        la $s4,replace
        li $t1,1
        lb $t3,0($s4)               
            counting:
        beq $t3,10,minor
        addiu $s4,$s4,1
        lb $t3,0($s4)
        addi $t1,$t1,1
            j counting 
            
            # This minor restores the variable containts in their respecive registers   
    minor:
    li $t6,1                # count the number of letters present in the extracted word
    la $s2,input            # load the base address of the input word
    lb $t0,0($s1)           # loading the first character of the para

    j extract



# This block stores the the replace word in place of the input word iff the word is found
    store2:             
        la $s4,replace
        li $t0,1
    storing2:
        beq $t0,$t4,intr
            lb $t2,0($s4)
            sb $t2,0($s5)
            addiu $t0,$t0,1
            addiu $s4,$s4,1
            addiu $s5,$s5,1
    j storing2
    j intr
    
    # This block is used to restore the original word present in the paragraph if the input word is not found
    store1:
        li $t0,1
        la $s0,copy
    storing1:
            beq $t0,$t6,intr
            lb $t2,0($s0)
            sb $t2,0($s5)
            addiu $t0,$t0,1
            addiu $s0,$s0,1
            addiu $s5,$s5,1
        j storing1



# This block is used to re-initialize the register containt after one itteration        
    intr:

        la $s4,replace
        lb $t0,0($s1)
        beq $t0,10,Display
        la $s0,copy
        li $t6,1
        addiu $s1,$s1,1
        lb $t0,0($s1)
        sb $t8,0($s5)
        addiu $s5,$s5,1



# This block is used to extract each word from the paragraph and store it in another variable called copy
    extract:
        lb $t8,0($s1)
        beq $t0,32,compare
        beq $t0,46,compare
        beq $t0,10,compare
        beq $t0,44,compare
        beq $t0,40,compare
        beq $t0,41,compare
        beq $t0,39,compare
        beq $t0,34,compare
        beq $t0,45,compare
        beq $t0,58,compare
        beq $t0,59,compare
        beq $t0,63,compare
        beq $t0,33,compare
        beq $t0,123,compare
        beq $t0,125,compare
        beq $t0,91,compare
        beq $t0,93,compare
        beq $t0,96,compare
        beq $t0,95,compare
        sb $t0,0($s0)
        addi $t6,$t6,1
        addiu $s0,$s0,1
        addiu $s1,$s1,1
        lb $t0,0($s1)
    j extract
    
    #Compare the extracted word and the input word
    compare:
        sb $t5,0($s0)
        la $s2,input
        la $s0,copy
        lb $t2,0($s2)
        lb $t3,0($s0)
        bne $t6,$t4,store1
        li $s7,0
    check:
        bne $t2,$t3,checkagain
        backagain:
        addi $s7,$s7,1
        beq $s7,$t4,success
        addiu $s2,$s2,1
        addiu $s0,$s0,1
        lb $t2,0($s2)
        lb $t3,0($s0)

    j check


# This block is used to handle the case sensitiveness of the program
    checkagain:
        addi $t3,$t3,32
        addi $t0,$t3,-64
        beq $t2,$t3,backagain
        beq $t2,$t0,backagain
        j store1
        
        # This block is used to count the number of times the word is present in the paragraph      
   success:

    addi $t7,$t7,1
    j store2    



# This block display the messeges according to their results
Display:
    bne $t4,$t1,errormsg
    beq $t7,0,msg
    li $v0,4
    la $a0,match
    syscall
    li $v0,1
    la $a0,($t7)
    syscall
    li $v0,4
    la $a0,line
    syscall
    li $v0,4
    la $a0,origpar
    syscall
    li $v0,4
    la $a0,para
    syscall
    li $v0,4
    la $a0,result
    syscall
    li $v0,4
    la $a0,copypara
    syscall
    #j exit


msg1:
    li $v0,4
    la $a0,nomatch
    syscall
    li $v0,4
    la $a0,origpar
    syscall
    li $v0,4
    la $a0,para
    syscall
    #j exit


errormsg:
    li $v0,4
    la $a0,match
    syscall
    li $v0,1
    la $a0,($t7)
    syscall
    li $v0,4
    la $a0,line
    syscall
    li $v0,4
    la $a0,error
    syscall
    li $v0,4
    la $a0,origpar
    syscall
    li $v0,4
    la $a0,para
    syscall


# The exit block
   # exit:
    #li $v0,10
    #syscall

    la $a0, msg    #print 'please enter sentence'
    li $v0, 4
    syscall


    la $a0, string    #input sentence
    li $a1, 100
    li $v0, 8
    syscall
   
    la $a0, msg2    #print 'please enter char'
    li $v0, 4
    syscall

    la $a0, word   #input character
    li $a3, 8
    li $v0, 8
    syscall
    
    la $s0, word
    lb $a2, ($s0) # first char in word
    la $s1, string
    lb $a0, ($s1) #first char in string 
    
    li $a3,0  #k=0
    li  $a1,0 #n=0
  word_len:
      beq $a2, $zero,end3
       addi $a3,$a3,1
       addi $s0,$s0,1
       lb $a2,($s0)
       j word_len
    end3: 
    sub $a3,$a3,1
    #sub $a3,$a3,1 #word_len
   str_len:
       beq $a0, $zero,end2
       addi $a1,$a1,1
       addi $s1,$s1,1
       lb $a0,($s1)
       j str_len
       end2: 
       sub $a1,$a1,1 #str_len
       
     la $s0, word
     lb $a2, ($s0) # first char in word
     la $s1, string
     lb $a0, ($s1) #first char in string 
count_word_occurences:
	li	$v1, 0		# count
	li	$t0, 0		# i
	sub	$t1, $a1, $a3	# str_len - word_len
loop_i:
	bgt 	$t0, $t1, exit1	 #i>str_len - word_len
         li	$t2, 1	  	# found = 1
	 li	$t3, 0		# j=0
	
loop_j:
	bge	$t3, $a3, exit_j  #j>word_len
	add	$t4, $s1, $t0	# &str[i]  
	add	$t4, $t4, $t3	# &str[i+j]
	lb	$t4, 0($t4)	# str[i+j]
	add	$t5, $s0, $t3	# &word[j]
	lb	$t5, 0($t5)	# word[j]
	beq 	$t4, $t5, skip
	li	$t2, 0		# found = 0
	j	exit_j		# break
	

skip:
	add	$t3, $t3, 1	# j ++
	j	loop_j
	

exit_j:
	beq	$t2, $0, skip2 #found==1
	add	$v1, $v1, 1	# count ++
skip2:
	add	$t0, $t0, 1	# i ++
	j	loop_i

exit1:
#li $v1, 10	
    la $a0, command3
    li $v0, 4
    syscall
    la $a0, word
    li $v0, 11
    syscall
    la $a0, command4
    li $v0, 4
    syscall

    la $a0, string
    li $v0, 4
    syscall
    
    li $v0, 1
    move $a0, $v1
    syscall

    la $a0, command5
    li $v0, 4
    syscall

     j Exit
     
     
c4_body:
la $a0, msg5    #print 'please enter sentence'
    li $v0, 4
    syscall


    la $a0, string5    #input sentence
    li $a1, 100
    li $v0, 8
    syscall
   
    la $a0, msg25    #print 'please enter char'
    li $v0, 4
    syscall

    la $a0, word5   #input character
    li $a3, 8
    li $v0, 8
    syscall
    
la $s0, word5
    lb $a2, ($s0) # first char in word
 la $s1, string5
    lb $a0, ($s1) #first char in string 
    
 li $a3,0  #k=0
 li  $a1,0 #n=0
   word_len5:
     beq $a2, $zero,end6
       addi $a3,$a3,1
       addi $s0,$s0,1
       lb $a2,($s0)
       j word_len5
    end6: 
    sub $a3,$a3,1
    #sub $a3,$a3,1 #word_len
   str_len5:
    beq $a0, $zero,end25
       addi $a1,$a1,1
       addi $s1,$s1,1
       lb $a0,($s1)
       j str_len5
       end25: 
       sub $a1,$a1,1 #str_len
       
     la $s0, word5
    lb $a2, ($s0) # first char in word
 la $s1, string5
    lb $a0, ($s1) #first char in string 
count_word_occurences5:
	li	$v1, 0		# count
	li	$t0, 0		# i
	sub	$t1, $a1, $a3	# str_len - word_len
loop_i5:
	bgt 	$t0, $t1, exit5	 #i>str_len - word_len
         li	$t2, 1	  	# found = 1
	 li	$t3, 0		# j=0
	
loop_j5:
	bge	$t3, $a3, exit_j5  #j>word_len
	add	$t4, $s1, $t0	# &str[i]  
	add	$t4, $t4, $t3	# &str[i+j]
	lb	$t4, 0($t4)	# str[i+j]
	add	$t5, $s0, $t3	# &word[j]
	lb	$t5, 0($t5)	# word[j]
	beq 	$t4, $t5, skip5
	li	$t2, 0		# found = 0
	j	exit_j5		# break
	

skip5:
	add	$t3, $t3, 1	# j ++
	j	loop_j5
	

exit_j5:
	beq	$t2, $0, skip25 #found==1
	la $a0, searchmsg4
          li $v0,4
          syscall
	li $v0 , 1
	move $t7 , $a0
	move $a0 , $t0
	syscall
	la $a0, new_line
          li $v0,4
          syscall
	move $a0 , $t7
	add	$v1, $v1, 1	# count ++
skip25:
	add	$t0, $t0, 1	# i ++
	j	loop_i5

exit5:
#li $v1, 10	
la $a0, searchmsg1
    li $v0, 4
    syscall
 la $a0, word5
    li $v0, 11
    syscall
  la $a0, searchmsg2
    li $v0, 4
    syscall

    la $a0, string5
    li $v0, 4
    syscall
    
   li $v0, 1
    move $a0, $v1
    syscall

    la $a0, searchmsg3
    li $v0, 4
    syscall
    
    j Exit

Exit:
j loop2 # goto loop2
Exitprogram:
li $v0, 10 # system call code for exit 
syscall


